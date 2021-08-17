require 'savon'

module Cayan
  module Merchantware
    module GiftCard
      class Client
        WSDL = 'https://ps1.merchantware.net/Merchantware/ws/ExtensionServices/v45/Giftcard.asmx?WSDL'

        attr_accessor :credentials, :wsdl

        def initialize(credentials, wsdl: WSDL)
          @credentials = credentials
          @wsdl = wsdl
          @client = Savon.client(
            wsdl: self.wsdl,
            convert_request_keys_to: :camelcase
          )
        end

        def activate_card(payment_data, request)
          request(:activate_card, {
            payment_data: payment_data,
            request: request
          })
        end

        def add_points(payment_data, request)
          request(:add_points, {
            payment_data: payment_data,
            request: request
          })
        end

        def add_value(payment_data, request)
          request(:add_value, {
            payment_data: payment_data,
            request: request
          })
        end

        def balance_inquiry(payment_data, request)
          request(:balance_inquiry, {
            payment_data: payment_data,
            request: request
          })
        end

        def refund(payment_data, request)
          request(:refund, {
            payment_data: payment_data,
            request: request
          })
        end

        def remove_points(payment_data, request)
          request(:remove_points, {
            payment_data: payment_data,
            request: request
          })
        end

        def sale(payment_data, request)
          request(:sale, {
            payment_data: payment_data,
            request: request
          })
        end

        def void(request)
          request(:void, {
            request: request
          })
        end

        private

        def request(name, payload = {})
          @client
            .call(name.to_sym, message: payload.merge({
              credentials: credentials
            }))
            .body
            .dig(:"#{name}_response", :"#{name}_result")
        end
      end
    end
  end
end