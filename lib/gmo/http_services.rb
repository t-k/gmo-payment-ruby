require "cgi"
require "gmo/json"

module GMO
  class Response

    attr_reader :status, :body, :headers
    def initialize(status, body, headers)
      @status  = status
      @body    = body
      @headers = headers
    end

  end

  module HTTPService

    def self.included(base)
      base.class_eval do
        def self.server(options = {})
          options[:host]
        end
      end# end class_eval
    end
  end

  module NetHTTPService
    def self.included(base)
      base.class_eval do
        require "net/http" unless defined?(Net::HTTP)
        require "net/https"

        include GMO::HTTPService

        def self.make_request(path, args, verb, options = {})
          args.merge!({:method => verb}) && verb = "post" if verb != "get" && verb != "post"

          http = create_http(server(options), options)
          http.use_ssl = true

          http.start do |h|
            response = if verb == "post"
              if /\.json\Z/ =~ path
                headers = { "Content-Type" => "application/json" }
                h.post(path, args.to_json, headers)
              else
                h.post(path, encode_params(args))
              end
            else
              h.get("#{path}?#{encode_params(args)}")
            end
            GMO::Response.new(response.code.to_i, response.body, response)
          end
        end

        protected

          def self.encode_params(param_hash)
            ((param_hash || {}).collect do |key_and_value|
              key_and_value[1] = GMO::JSON.dump(key_and_value[1]) if key_and_value[1].class != String
              # converting to Shift-JIS
              sjis_value = NKF.nkf('-s', key_and_value[1])
              "#{key_and_value[0].to_s}=#{CGI.escape sjis_value}"
            end).join("&")
          end

          def self.create_http(server, options)
            if options[:proxy]
              proxy = URI.parse(options[:proxy])
              http  = Net::HTTP.new \
                server, 443,
                proxy.host, proxy.port,
                proxy.user, proxy.password
            else
              http = Net::HTTP.new server, 443
            end
            if options[:timeout]
              http.open_timeout = options[:timeout]
              http.read_timeout = options[:timeout]
            end
            http
          end

      end
    end
  end
end
