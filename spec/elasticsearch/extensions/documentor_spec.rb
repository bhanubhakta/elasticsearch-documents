require 'spec_helper'
require 'logger'

module Elasticsearch::Extensions
  describe Documentor do

    let(:logger) { Logger.new(STDOUT) }
    before do
      Documentor.configure do |config|
        config.logger     = logger
        config.log        = true
      end
    end

    describe '.configuration' do
      subject(:config) { Documentor.configuration }

      specify { expect(config.url).to eql 'http://example.com:9200' }
      specify { expect(config.index_name).to eql 'test_index' }
      specify { expect(config.mappings).to eql( :fake_mappings ) }
      specify { expect(config.settings).to eql( :fake_settings ) }
      specify { expect(config.logger).to equal logger }
      specify { expect(config.logger).to be_true }
    end

    describe '.client' do
      subject(:client) { Documentor.client }

      it 'creates an instance of Elasticsearch::Transport::Client' do
        expect(client).to be_instance_of Elasticsearch::Transport::Client
      end

      it 'caches the client instance' do
        c1 = Documentor.client
        c2 = Documentor.client
        expect(c1).to equal c2
      end
    end

    describe '.index_name' do
      specify { expect(Documentor.index_name).to eq 'test_index' }
    end

    describe '.logger' do
      specify { expect(Documentor.logger).to equal logger }
    end

  end
end
