# frozen_string_literal: true
ActiveRecord::Schema.define do
  create_table :cached_queries do |t|
    t.string :name
  end

  execute "create type people_state as enum ('pending', 'active')"

  create_table :people do |t|
    t.string :first_name
    t.string :last_name
    t.column :state, 'people_state', default: 'pending'
    t.boolean :is_priority, default: false
  end

  create_table :phrases do |t|
    t.string :text
    t.references :person
  end

  create_table :test_models do |t|
    t.string :name
  end

  create_table :relatives do |t|
    t.string :name
    t.references :parent_error_model
    t.references :collection_error_model
  end

  create_table :parent_error_models
  create_table :collection_error_models
end
