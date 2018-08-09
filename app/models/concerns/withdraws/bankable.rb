module Withdraws
  module Bankable
    extend ActiveSupport::Concern

    included do
      validates_presence_of :fund_extra

      delegate :name, to: :member, prefix: true

      alias_attribute :remark, :id
    end

    def set_fee
      self.sum ||= 0.0
      Rails.logger.info "Withdraw amount: #{self.sum} for Bank: #{channel.currency}"
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
      if self.fee.blank?
        self.fee = 0
      end
      if !channel.min.blank? && channel.min.to_d > self.fee 
        self.fee = channel.min.to_d
      end
      Rails.logger.info "Withdrawal Fee: #{self.fee}"
    end
  end
end
