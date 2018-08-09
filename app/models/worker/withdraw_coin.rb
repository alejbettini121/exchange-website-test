module Worker
  class WithdrawCoin

    def process(payload, metadata, delivery_info)
      payload.symbolize_keys!

      Withdraw.transaction do
        Rails.logger.info "Withdraw Coin Worker with payload: #{payload.inspect}"
        withdraw = Withdraw.lock.find payload[:id]
        Rails.logger.info "Withdraw Found: #{withdraw.inspect}"
        return unless withdraw.processing?

        withdraw.whodunnit('Worker::WithdrawCoin') do
          withdraw.call_rpc
          withdraw.save!
        end
      end

      Withdraw.transaction do
        Rails.logger.info "Withdraw Coin payload: #{payload.inspect}"
        withdraw = Withdraw.lock.find payload[:id]
        begin
          Rails.logger.info "Withdraw Transaction: #{withdraw.inspect}"
          ccy = Currency.find_by_code(withdraw.currency)
          Rails.logger.info "Currency: #{ccy.inspect}"
          return if withdraw.blank? || !withdraw.almost_done?
          Rails.logger.info "Withdraw Coin withdrawal start"
          if !ccy.api_client.blank? && ccy.api_client.casecmp("bitgo").zero?
            Rails.logger.info "BitGo Withdraw Coin started"
            balance = ccy.coin_api.load_balance!
            Rails.logger.info "Balance: #{balance}"
            return withdraw.suspect! if balance < withdraw.sum
            pa = withdraw.account.payment_address
            Rails.logger.info "Withdraw Coin Payment address: #{pa.inspect}"
            txid = ccy.coin_api.create_withdrawal!(
              { address: pa.address },
              { address: withdraw.fund_uid},
              withdraw.amount.to_d
            )
            Rails.logger.info "Transaction ID: #{txid}"
          elsif withdraw.currency == 'eth'
            balance = open('http://your_geth_server_ip/cgi-bin/total.cgi').read.rstrip.to_f
            raise Account::BalanceError, 'Insufficient coins' if balance < withdraw.sum

            fee = [withdraw.fee.to_f || withdraw.channel.try(:fee) || 0.0005, 0.1].min
            CoinRPC[withdraw.currency].personal_unlockAccount("base_account_address", "", 36000)
            txid = CoinRPC[withdraw.currency].eth_sendTransaction(from: "base_account_address",to: withdraw.fund_uid, value: '0x ' +((withdraw.amount.to_f ).to_i.to_s(16)))
          else
            balance = CoinRPC[withdraw.currency].getbalance.to_d
            raise Account::BalanceError, 'Insufficient coins' if balance < withdraw.sum

            fee = [withdraw.fee.to_f || withdraw.channel.try(:fee) || 0.0005, 0.1].min

            CoinRPC[withdraw.currency].settxfee fee
            txid = CoinRPC[withdraw.currency].sendtoaddress withdraw.fund_uid, withdraw.amount.to_f

          end
          withdraw.whodunnit('Worker::WithdrawCoin') do
            withdraw.update_column :txid, txid

            # withdraw.succeed! will start another transaction, cause
            # Account after_commit callbacks not to fire
            withdraw.succeed
            withdraw.save!
          end
        rescue Exception => e 
          Rails.logger.error "#{e.class}: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          withdraw.reject if !withdraw.blank?
        end
      end
    end

  end
end
