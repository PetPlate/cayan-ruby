require 'savon'

module Cayan
  module Merchantware
    module Credit
      class Client
        WSDL = 'https://ps1.merchantware.net/Merchantware/ws/RetailTransaction/v45/Credit.asmx?WSDL'

        attr_accessor :credentials, :wsdl

        def initialize(credentials, wsdl: WSDL)
          @credentials = credentials
          @wsdl = wsdl
          @client = Savon.client(
            wsdl: self.wsdl,
            convert_request_keys_to: :camelcase
          )
        end

        def board_card(payment_data)
          request(:board_card, {
            payment_data: payment_data
          })
        end

        def find_boarded_card(vault_token_request)
          request(:find_boarded_card, {
            request: vault_token_request
          })
        end
        
        def adjust_tip(tip_request)
          request(:adjust_tip, {
            request: tip_request
          })
        end

        def attach_signature(signature_request)
          request(:attach_signature, {
            request: signature_request
          })
        end

        def authorize(payment_data, authorization_request)
          request(:authorize, {
            payment_data: payment_data,
            request: authorization_request
          })
        end

        def capture(capture_request)
          request(:capture, {
            request: capture_request
          })
        end

        def update_boarded_card(update_boarded_card_request)
          request(:update_boarded_card, {
            request: update_boarded_card_request
          })
        end

        def force_capture(payment_data, force_capture_request)
          request(:force_capture, {
            payment_data: payment_data,
            request: force_capture_request
          })
        end
        
        def refund(payment_data, refund_request)
          request(:refund, {
            payment_data: payment_data,
            request: refund_request
          })
        end

        def sale(payment_data, sale_request)
          request(:sale, {
            payment_data: payment_data,
            request: sale_request
          })
        end

        def settle_batch
          request(:settle_batch)
        end

        def unboard_card(vault_token_request)
          request(:unboard_card, {
            request: vault_token_request
          })
        end

        def void(void_request)
          request(:void, {
            request: void_request
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