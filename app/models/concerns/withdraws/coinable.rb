module Withdraws
  module Coinable
    extend ActiveSupport::Concern

    def set_fee
      self.sum ||= 0.0
      Rails.logger.info "Withdraw amount: #{self.sum} for Coin: #{channel.currency}"
      Rails.logger.info "Withdraw channel: #{channel.inspect}"
      if !channel.fee_type.blank? && channel.fee_type.casecmp("percentage").zero?
        if !channel.fee.blank? && channel.fee.to_d > 0 && channel.fee.to_d <=100
          self.fee = (self.sum * channel.fee.to_d)/100
        end
      elsif !channel.fee_type.blank? && channel.fee_type.casecmp("fix").zero?
        if !channel.fee.blank? 
          self.fee = channel.fee.to_d
        end
      end
      if self.fee.blank? || self.fee == 0
        self.fee = "0.0001".to_d
      end
      Rails.logger.info "Withdrawal Fee: #{self.fee}"
    end

    def blockchain_url
      currency_obj.blockchain_url(txid)
    end

    def audit!
      ccy = Currency.find_by_code(currency)
      result = Hash.new
      if !ccy.api_client.blank? && ccy.api_client.casecmp("bitgo").zero?
	      result[:isvalid] = true
	      result[:ismine] = false
      else
      	result = CoinRPC[currency].validateaddress(fund_uid)
      end
      if result.nil? || (result[:isvalid] == false)
        Rails.logger.info "#{self.class.name}##{id} uses invalid address: #{fund_uid.inspect}"
        reject
        save!
      elsif (result[:ismine] == true) || PaymentAddress.find_by_address(fund_uid)
        Rails.logger.info "#{self.class.name}##{id} uses hot wallet address: #{fund_uid.inspect}"
        reject
        save!
      else
        super
      end
    end

    def as_json(options={})
      super(options).merge({
        blockchain_url: blockchain_url
      })
    end

  end
end

