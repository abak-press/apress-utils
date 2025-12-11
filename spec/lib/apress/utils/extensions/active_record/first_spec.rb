# frozen_string_literal: true
require "spec_helper"

describe Apress::Utils::Extensions::ActiveRecord::FinderMethods do
  it "cache records" do
    # странное решение было, нет ни бенчмарков ни исследования. Доверимся программистам RoR, т.к. поведение сохранилось до последней версии
    if Rails::VERSION::MAJOR == 4
      expect { Person.first.inspect }.to make_database_queries(matching: /SELECT.*FROM.*people"\s*LIMIT 1/)
    end
  end
end
