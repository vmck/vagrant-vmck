require 'faraday'
require 'json'

module VagrantPlugins
  module Vmck
    class ApiClient

      def initialize(url)
        @logger = Log4r::Logger.new('vmck::apiclient')
        @client = Faraday.new({ :url => url })
      end

      def post(path)
        request(path, :post)
      end

      def delete(path)
        request(path, :delete)
      end

      def request(path, method = :get)
        @logger.info "Request: #{path}"
        result = @client.send(method) do |req|
          req.url(path, {})
        end

        unless method == :delete
          body = JSON.parse(result.body)
          @logger.info "Response: #{body}"
        end

        unless /^2\d\d$/ =~ result.status.to_s
          raise(Errors::APIStatusError, {
            :path => path,
            :status => result.status,
            :response => body.inspect
          })
        end

        return body
      end

    end

    class Client
      def initialize(url)
        @api = ApiClient.new(url)
        @logger = Log4r::Logger.new('vmck::client')
      end

      def create
        return @api.post('/v0/jobs')
      end

      def get(id)
        job = @api.request("/v0/jobs/#{id}")
        job['ready_for_ssh'] = true if job['state'] == 'running' and job['ssh']
        return job
      end

      def stop(id)
        return @api.delete("/v0/jobs/#{id}")
      end
    end
  end
end
