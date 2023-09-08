# frozen_string_literal: true

class CollectionErrorModel < ActiveRecord::Base
  include Apress::Utils::Extensions::ActiveRecord::ValidateUniquenessInMemory

  has_many :relatives

  validate :validate_unique_relatives

  private

  def validate_unique_relatives
    validate_uniqueness_of_in_memory(
      relatives, [:name],
      'Duplicate field', :value,
      assign_error_to_collection: true,
      additional_message: 'Change duplicate fields'
    )
  end
end
