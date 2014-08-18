# coding: utf-8
module Apress
  module Utils
    module Extensions
      module ActiveRecord
        module DeleteWithTransactions
          def self.included(base) #:nodoc:
            base.alias_method_chain :delete, :transactions
          end

          def delete_with_transactions(*args, &block) #:nodoc:
            with_transaction_returning_status(:delete_without_transactions, *args, &block)
          end
        end
      end
    end
  end
end
