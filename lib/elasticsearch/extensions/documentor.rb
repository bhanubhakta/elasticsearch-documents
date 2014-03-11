require "elasticsearch"
require "logger"
require "elasticsearch/extensions/documentor/version"
require "elasticsearch/extensions/documentor/document"
require "elasticsearch/extensions/documentor/index"
require "elasticsearch/extensions/documentor/indexer"
require "elasticsearch/extensions/documentor/queryable"
require "elasticsearch/extensions/documentor/utils"

module Elasticsearch
  module Extensions
    module Documents

      class << self
        attr_accessor :client, :configuration

        def client
          @client ||= Elasticsearch::Client.new({
            host: self.configuration.url,
            log:  self.configuration.log,
          })
        end

        def configure
          self.configuration ||= Configuration.new
          yield configuration
        end

        def index_name
          self.configuration.index_name
        end

        def logger
          self.configuration.logger
        end
      end

      class Configuration
        attr_accessor :url, :index_name, :mappings, :settings, :log, :logger

        def initialize
          @logger = Logger.new(STDOUT)
          @log    = true
        end
      end

    end
  end
end

