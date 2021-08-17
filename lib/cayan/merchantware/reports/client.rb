require 'savon'

module Cayan
  module Merchantware
    module Reports
      class Client
        WSDL = 'https://ps1.merchantware.net/Merchantware/ws/TransactionHistory/v4/Reporting.asmx?WSDL'

        attr_accessor :credentials, :wsdl

        def initialize(credentials, wsdl: WSDL)
          @credentials = credentials
          @wsdl = wsdl
          @client = Savon.client(
            wsdl: self.wsdl,
            convert_request_keys_to: :lower_camelcase
          )
        end

        def current_batch_summary(filters)
          request(:current_batch_summary, filters)
        end

        def current_batch_transactions
          request(:current_batch_transactions)
        end

        def summary_by_date(filters)
          request(:summary_by_date, filters)
        end

        def transactions_by_date(filters)
          request(:transactions_by_date, filters)
        end

        def transactions_by_reference(filters)
          response = @client.call(:transactions_by_date, message: credentials.merge(filters))

          response.body.dig(:transactions_by_reference_response, :transactions_by_reference_result)
        end

        def transactions_by_transaction_id(transaction_id)
          response = @client.call(:detailed_transaction_by_transaction_id, message: credentials.merge({
            merchant_transaction_id: transaction_id
          }))
          
          response.body.dig(:transactions_by_transaction_id_response, :transactions_by_transaction_id_result)
        end

        def detailed_transaction_by_reference(filters)
          request(:detailed_transaction_by_reference, filters)
        end

        def detailed_transaction_by_transaction_id(transaction_id)
          request(:detailed_transaction_by_transaction_id, {
            merchant_transaction_id: transaction_id
          })
        end

        private

        def request(name, payload = {})
          @client
            .call(name.to_sym, message: credentials.merge(payload))
            .body
            .dig(:"#{name}_response", :"#{name}_result")
        end
      end
    end
  end
end