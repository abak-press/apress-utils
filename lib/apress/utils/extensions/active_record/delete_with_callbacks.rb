# coding: utf-8
module Apress
  module Utils
    module Extensions
      module ActiveRecord
        module DeleteWithCallbacks
          extend ActiveSupport::Concern

          included do
            extend ActiveModel::Callbacks

            define_model_callbacks :delete, :only => [:after, :before]

            def delete
              run_callbacks :delete do
                super
              end
            end
          end
        end
      end
    end
  end
end
