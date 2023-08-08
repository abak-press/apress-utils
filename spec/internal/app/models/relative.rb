# frozen_string_literal: true

class Relative < ActiveRecord::Base
  belongs_to :parent_error_model
  belongs_to :collection_error_model
end
