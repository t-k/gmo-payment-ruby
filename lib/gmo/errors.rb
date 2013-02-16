# begin
#   # do something...
# rescue GMO::Payment::APIError => e
#   puts e.response_body
#   # => ErrCode=hoge&ErrInfo=hoge
#   puts e.error_info
#   # {"ErrCode"=>"hoge", "ErrInfo"=>"hoge"}
# end

module GMO

  class GMOError < StandardError; end

  module Payment
    class Error < ::GMO::GMOError
      attr_accessor :error_info, :response_body

      def initialize(response_body = "", error_info = nil)
        if response_body &&  response_body.is_a?(String)
          self.response_body = response_body.strip
        else
          self.response_body = ''
        end
        if error_info.nil?
          begin
            error_info = Rack::Utils.parse_nested_query(response_body.to_s)
          rescue
            error_info ||= {}
          end
        end
        self.error_info = error_info
        message = self.response_body
        super(message)
      end
    end

    class ServerError < Error
    end

    class APIError < Error
      def initialize(error_info = {})
        self.error_info = error_info
        self.response_body = "ErrCode=#{error_info["ErrCode"]}&ErrInfo=#{error_info["ErrInfo"]}"
        message = self.response_body
        super(message)
      end
    end

  end

end