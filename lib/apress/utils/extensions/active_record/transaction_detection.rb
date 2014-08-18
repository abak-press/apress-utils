# coding: utf-8
module Apress
  module Utils
    module Extenstions
      module ActiveRecord
        module TransactionDetection

          def self.included(base) #:nodoc:
            base.send(:extend,  Methods)
            base.send(:include, Methods)
          end

          def self.extended(base) #:nodoc:
            base.send(:extend,  Methods)
            base.send(:include, Methods)
          end

          module Methods
            def in_transaction?
              false === connection.outside_transaction?
            end
          end

        end
      end
    end
  end
end
