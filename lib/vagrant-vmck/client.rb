require 'faraday'
require 'json'

module VagrantPlugins
  module Vmck
    class Client

      def initialize(url)
        @logger = Log4r::Logger.new('vmck::client')
        @client = Faraday.new({ :url => url })
      end

      def request(method, path, data=nil)
        @logger.info "Request: #{path}"

        result = @client.send(method) do |req|
          req.url(path)
          if data
            req.headers['Content-Type'] = 'application/json'
            req.body = JSON.generate(data)
          end
        end

        if method == :delete
          body = nil
        else
          body = JSON.parse(result.body)
          @logger.info "Response: #{body}"
          return body
        end

        if result.status < 200 or result.status >= 300
          raise({
            :path => path,
            :status => result.status,
            :response => body.inspect,
          })
        end

      end

      def create(options)
        request(:post, "/v0/jobs", options)
      end

      def get(id)
        request(:get, "/v0/jobs/#{id}")
      end

      def stop(id)
        request(:delete, "/v0/jobs/#{id}")
      end
    end
  end
end
