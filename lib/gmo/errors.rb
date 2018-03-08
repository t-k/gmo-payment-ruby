# begin
#   # do something...
# rescue GMO::Payment::APIError => e
#   puts e.response_body
#   # => ErrCode=hoge&ErrInfo=hoge
#   puts e.error_info
#   # {"ErrCode"=>"hoge", "ErrInfo"=>"hoge"}
# end

module GMO

  class GMOError < StandardError
    ERROR_INFO_SEPARATOR = '|'.freeze

    private

      def error_message(info, locale)
        ::GMO::Const::API_ERROR_MESSAGES[locale][info] || info
      end
  end

  module Payment
    class Error < ::GMO::GMOError
      attr_accessor :error_info, :response_body, :locale, :error_messages

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
      def initialize(error_info = {}, locale = ::GMO::Const::DEFAULT_LOCALE)
        self.error_info = error_info
        self.locale = locale
        self.response_body = "ErrCode=#{error_info["ErrCode"]}&ErrInfo=#{error_info["ErrInfo"]}"
        set_error_messages
        message = self.response_body
        super(message)
      end

      private

        def set_error_messages
          self.error_messages = self.error_info['ErrInfo'].to_s.split(ERROR_INFO_SEPARATOR)
                                                     .map { |e| error_message(e, locale) || e }
          self.response_body += "&ErrMessage=#{self.error_messages.join(ERROR_INFO_SEPARATOR)}"
        end
    end

  end

end
