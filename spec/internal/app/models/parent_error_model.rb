# frozen_string_literal: true

class ParentErrorModel < ActiveRecord::Base
  include Apress::Utils::Extensions::ActiveRecord::ValidateUniquenessInMemory

  has_many :relatives
  validate :validate_unique_relatives

  private

  def validate_unique_relatives
    validate_uniqueness_of_in_memory(
      relatives, [:name],
      'Duplicate field', :value
    )
  end
end
