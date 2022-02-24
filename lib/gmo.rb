require "rack/utils"
require "nkf"

require "gmo/const"
require "gmo/errors"
require "gmo/http_services"
require "gmo/shop_api"
require "gmo/site_api"
require "gmo/shop_and_site_api"
require "gmo/remittance_api"
require "gmo/version"

# Ruby client library for the GMO Payment Platform.

module GMO

  module Payment

    class API

      def initialize(options = {})
        @host = options[:host]
      end
      attr_reader :host

      def api(path, args = {}, verb = "post", options = {}, &error_checking_block)
        # Setup args for make_request
        path = "/payment/#{path}" unless path =~ /^\//
        options.merge!({ :host => @host })
        # Make request via the provided service
        result = GMO.make_request path, args, verb, options
        # Check for any 500 server errors before parsing the body
        if result.status >= 500
          error_detail = {
            :http_status => result.status.to_i,
            :body        => result.body,
          }
          raise GMO::Payment::ServerError.new(result.body, error_detail)
        end
        # Transform the body to Hash
        # "ACS=1&ACSUrl=url" => { "ACS" => "1", ACSUrl => "url" }
        key_values = result.body.to_s.split('&').map { |str| str.split('=', 2) }.flatten
        response = Hash[*key_values]
        # Transform the redirect_url
        # "ACS=2&RedirectUrl=https://manage.tds2gw.gmopg.jp/api/v2/brw/callback?transId=6e48e31f-2940-48e1-a702- ebba2f3373ee&t=dccc8a7ed85372c9accff576bff59b3a" => { "ACS" => "2", RedirectUrl => "https://manage.tds2gw.gmopg.jp/api/v2/brw/callback?transId=6e48e31f-2940-48e1-a702- ebba2f3373ee&t=dccc8a7ed85372c9accff576bff59b3a" }
        if response['RedirectUrl'].present? && response['t'].present? && response.keys.index('RedirectUrl') + 1 == response.keys.index('t')
          response['RedirectUrl'] = response['RedirectUrl'] + '&t=' + response['t']
          response.delete('t')
        end
        # converting to UTF-8
        body = response = Hash[response.map { |k,v| [k, NKF.nkf('-w',v)] }]
        # Check for errors if provided a error_checking_block
        yield(body) if error_checking_block
        # Return result
        if options[:http_component]
          result.send options[:http_component]
        else
          body
        end
      end

      # gmo.get_request("EntryTran.idPass", {:foo => "bar"})
      # GET /EntryTran.idPass with params foo=bar
      def get_request(name, args = {}, options = {})
        api_call(name, args, "get", options)
      end
      alias :get! :get_request

      # gmo.post_request("EntryTran.idPass", {:foo => "bar"})
      # POST /EntryTran.idPass with params foo=bar
      def post_request(name, args = {}, options = {})
        args = associate_options_to_gmo_params args
        api_call(name, args, "post", options)
      end
      alias :post! :post_request

      private

        def assert_required_options(required, options)
          missing = required.select { |param| options[param].nil? }
          raise ArgumentError, "Required #{missing.join(', ')} were not provided." unless missing.empty?
        end

        def associate_options_to_gmo_params(options)
          Hash[options.map { |k, v| [GMO::Const::INPUT_PARAMS[k], v] }]
        end

        def api_call(*args)
          raise "Called abstract method: api_call"
        end

    end

    class ShopAPI < API
      include ShopAPIMethods
    end

    class SiteAPI < API
      include SiteAPIMethods
    end

    class ShopAndSiteAPI < API
      include ShopAndSiteAPIMethods
    end

    class RemittanceAPI < API
      include RemittanceAPIMethods
    end

  end

  # Set up the http service GMO methods used to make requests
  def self.http_service=(service)
    self.send :include, service
  end

  GMO.http_service = NetHTTPService
end
