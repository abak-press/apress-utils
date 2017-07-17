require 'spec_helper'

RSpec.describe Apress::Utils::Extensions::ActiveRecord::ConnectionAdapters::PostgreSQLAdapter do
  it do
    if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 1
      skip 'Need enum defaults patch'
    else
      expect(Person.new.state).to eq('pending')
      expect(Person.new.state_was).to eq('pending')
    end
  end
end
