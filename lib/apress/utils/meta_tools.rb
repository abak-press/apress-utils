# coding: utf-8
module Apress
  module Utils
    module MetaTools
      def class?(obj)
        obj.is_a?(::Class)
      end

      def active_record?(obj)
        class?(obj) && obj.ancestors.include?(::ActiveRecord::Base)
      end

      def active_record_instance?(obj)
        obj.is_a?(::ActiveRecord::Base)
      end

      def class_name(obj)
        return obj.name       if class?(obj)
        return obj.class.name if obj.respond_to?(:class)
        nil
      end
    end
  end
end
