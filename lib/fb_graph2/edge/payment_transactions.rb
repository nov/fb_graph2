module FbGraph2
  class Edge
    module PaymentTransactions
      def payment_transactions(params = {})
        payments = self.edge :payment_transactions, params
        payments.collect! do |payment|
          Payment.new(payment[:id], payment).authenticate self.access_token
        end
      end
    end
  end
end