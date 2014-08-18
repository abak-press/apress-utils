# coding: utf-8
module Apress
  module Utils
    module Extensions
      module Authlogic
        module Login
          def self.included(base)
            base.alias_method_chain :find_with_case, :lower
          end

          def find_with_case_with_lower(field, value, sensitivity = true)
            if sensitivity
              send("find_by_#{field}", value)
            else
              where("LOWER(#{quoted_table_name}.#{field}) = ?", value.mb_chars.downcase).first
            end
          end
        end
      end
    end
  end
end
