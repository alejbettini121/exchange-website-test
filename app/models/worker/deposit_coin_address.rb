module Worker
  class DepositCoinAddress

    def process(payload, metadata, delivery_info)
      payload.symbolize_keys!
      Rails.logger.info "Payload: #{payload.inspect}"
      payment_address = PaymentAddress.find payload[:payment_address_id]
      return if payment_address.address.present?

      currency = payload[:currency]
      c = Currency.find_by_code(currency)
      Rails.logger.info "Currency details: #{c.inspect}"
      Rails.logger.info "Currency API: #{c.api_client}"
      if !c.api_client.blank? && c.api_client.casecmp("bitgo").zero?
        Rails.logger.info "Bitgo Wallet creation for coin: #{c.inspect}"
        acc = Account.find_by_id(payload[:account_id])
        Rails.logger.info "Account Details: #{acc.inspect}"
	      return unless acc
        #return unless acc.currency.coin?

        acc.payment_address.tap do |pa|
          pa.with_lock do
            next if pa.address.present?
            Rails.logger.info "Calling Bitgo API for Wallet creation."
            # Supply address ID in case of BitGo address generation if it exists.
            result = c.coin_api.create_address!(address_id: pa.details['bitgo_address_id'])
            Rails.logger.info "Wallet creation response from Bitgo: #{result.inspect}"
            result[:address] = result[:bitgo_address_id] if result[:address].blank?
            # Save all the details including address ID from BitGo to use it later.
            pa.update! \
              result.extract!(:address, :secret).merge!(details: pa.details.merge(result))

            # Enqueue address generation again if address is not provided.
            pa.enqueue_address_generation if pa.address.blank?

            #pusher_event(acc, pa) unless pa.address.blank?
            address = pa.address unless pa.address.blank?
          end
        end
      elsif currency == 'eth'
        address  = CoinRPC[currency].personal_newAccount("")
        open('http://your_eth_server_ip/cgi-bin/restart.cgi')  
      else
        address  = CoinRPC[currency].getnewaddress("payment")
      end

      if payment_address.update address: address
        ::Pusher["private-#{payment_address.account.member.sn}"].trigger_async('deposit_address', { type: 'create', attributes: payment_address.as_json})
      end
    end

  end
end
