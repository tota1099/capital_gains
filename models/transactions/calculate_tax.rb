module Transactions
  class CalculateTax
    class << self
      TAX_RATE = 0.2
      EXEMPTION_LIMIT = 20000

      def call(wallet:, transaction:)
        return 0.0 if transaction.buy?

        if is_loss?(wallet, transaction)
          wallet.add_loss(transaction)
          return 0.0
        end

        return 0.0 unless need_pay_tax?(transaction)

        gain = calculate_gain(wallet, transaction)
        return gain * TAX_RATE unless wallet.has_loss?
        
        calculate_tax_with_loss(wallet, gain)
      end

      private

      def calculate_tax_with_loss(wallet, gain)
        if gain <= wallet.loss_amount
          wallet.discount_loss(gain)
          return 0.0
        else
          remaining_gain = gain - wallet.loss_amount
          wallet.reset_loss
          remaining_gain * TAX_RATE
        end
      end

      def is_gain?(wallet, transaction)
        transaction.unit_cost > wallet.weighted_price
      end

      def is_loss?(wallet, transaction)
        transaction.unit_cost < wallet.weighted_price
      end

      def need_pay_tax?(transaction)
        transaction.price > EXEMPTION_LIMIT
      end

      def calculate_gain(wallet, transaction)
        (transaction.unit_cost - wallet.weighted_price) * transaction.quantity
      end
    end
  end
end
