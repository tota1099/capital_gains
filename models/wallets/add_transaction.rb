module Wallets
  class AddTransaction
    class << self
      def call(wallet:, transaction:)
        return wallet.process_buy(transaction) if transaction.buy?
        wallet.process_sell(transaction)
      end
    end
  end
end
