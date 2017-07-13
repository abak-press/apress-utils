require 'bundler/setup'

require 'pry-byebug'
require 'combustion'

require 'apress/utils'

Combustion.initialize! :all do
  config.action_controller.perform_caching = true
  config.perform_caching_queries = true
  config.cache_store = :memory_store, {size: 1.megabyte}
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
