# frozen_string_literal: true
require 'bundler/setup'

require 'combustion'

require 'apress/utils'
require 'pry-byebug'
require 'test_after_commit'
require 'db_query_matchers'

Combustion.initialize! :all do
  config.perform_caching_queries = true
  config.cache_store = :memory_store
end

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.before do
    Rails.cache.clear
  end

  config.filter_run_including focus: true
  config.run_all_when_everything_filtered = true
end
