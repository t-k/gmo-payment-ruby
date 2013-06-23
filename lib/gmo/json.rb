require "multi_json"
module GMO
  module JSON

    def self.dump(message)
      if MultiJson.respond_to?(:dump)
        MultiJson.dump(message)
      else
        MultiJson.encode(message)
      end
    end

  end
end