require 'rest-client'
require 'json'

module PushBot
  class Request
    def initialize(base)
      @base = base
    end

    def get(name=nil, options={})
      request(:get, name, options)
    end

    def post(name, options={})
      request(:post, name, options)
    end

    def put(name, options={})
      request(:put, name, options)
    end

    private

    def request(type, name, options)
      url = "https://api.pushbots.com/#{@base}"
      url << "/#{name}" if name

      headers = {
        'X-PushBots-AppID' => Config.config.id,
        'X-PushBots-Secret' => Config.config.secret,
        'Content-Type' => 'application/json'
      }

      if type == :get
        headers[:Token] = options[:token]
      end

      RestClient.send(type, url, JSON.dump(options), headers)
    end
  end
end
