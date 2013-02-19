require 'cgi'
require 'rack/utils'
require 'multi_json'

require 'gmo/errors'
require 'gmo/http_services'
require 'gmo/shop_api'
require 'gmo/site_api'
require 'gmo/shop_and_site_api'
require "gmo/version"

# Ruby client library for the GMO Payment Platform.
# Copyright 2013 Tatsuo Kaniwa
# tatsuo[at]kaniwa.biz

module GMO

  module Payment

    DEV_SERVER = "pt01.mul-pay.jp"
    # TODO: Set production server
    PRO_SERVER = "pt01.mul-pay.jp"

    class API

      def initialize(options = {})
        @development = options[:development] || true
      end
      attr_reader :development

      def api(path, args = {}, verb = "post", options = {}, &error_checking_block)
        # Setup args for make_request
        path = "/payment/#{path}" unless path =~ /^\//
        options.merge!({ "development" => @development })
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
        # Parse the body as Query string
        body = response = Rack::Utils.parse_nested_query(result.body.to_s)
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
        api_call(name, args, "post", options)
      end
      alias :post! :post_request

      private

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

  end

  # Set up the http service GMO methods used to make requests
  def self.http_service=(service)
    self.send :include, service
  end

  GMO.http_service = NetHTTPService
end