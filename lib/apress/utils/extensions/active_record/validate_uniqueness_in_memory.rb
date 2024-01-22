# frozen_string_literal: true
module Apress::Utils::Extensions::ActiveRecord
  module ValidateUniquenessInMemory

    def self.included(model)
      model.send(:include, ValidateMethods)
    end

  end

  module ValidateMethods
    def self.included(model)
      model.class_eval do
        # Validate that the objects in collection are unique when compared against all their non-blank attrs.
        #   If not add message to the base errors.
        #
        # options:
        #   assign_error_to_collection - assign error message to each model in collection
        #   additional_message - set additional message to :base error for a current model
        #   separate_empty_attr - specify attr for independent processing if duplicated and empty
        #   empty_attr_message - set message to :base error for a current model in case if has empty field
        #
        # Returns Object
        def validate_uniqueness_of_in_memory(collection, attrs, message, attribute = :base, options = {})
          duplicates = []
          empties = []
          hashes = collection.inject({}) do |hash, record|
            # getting a unique key for the record
            key = attrs.map {|a| record.send(a).to_s }.join
            if key.blank? || record.marked_for_destruction?
              key = record.object_id
            end

            duplicates.push(record, hash[key]) if hash[key] && options[:assign_error_to_collection]
            hash[key] = record unless hash[key]

            hash
          end

          # process duplicated records with empty fields
          if options[:separate_empty_attr] && options[:empty_attr_message] && duplicates.present?
            empties = duplicates.reject { |record| record.send(options[:separate_empty_attr]).present? }
            duplicates -= empties

            empties.each do |record|
              record.errors.add(attribute, options[:empty_attr_message])
            end
          end

          if options[:assign_error_to_collection] && duplicates.present?
            duplicates.each do |duplicate|
              duplicate.errors.add(attribute, message)
            end

            errors.add(:base, options[:additional_message]) if options[:additional_message] && empties.empty?
          end

          if collection.length > hashes.length
            errors.add(attribute, message)
          end
        end
      end
    end
  end
end
