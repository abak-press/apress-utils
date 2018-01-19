# -*- encoding : utf-8 -*-

module Apress::Utils::Extensions::ActiveRecord::VirtualAttrs
  module ClassMethods
    attr_accessor :virtual_attr_names

    def virtual_attrs(*attrs)
      @virtual_attr_names ||= []
      @virtual_attr_names += attrs

      attr_accessor *@virtual_attr_names
    end
  end

  def self.prepended(base)
    class << base
      prepend ClassMethods
    end
  end

  def [](attr_name)
    if virtual_attrs && virtual_attrs.include?(attr_name)
      send(attr_name)
    else
      read_attribute(attr_name)
    end
  end

  def []=(attr_name, value)
    if virtual_attrs && virtual_attrs.include?(attr_name)
      send("#{attr_name}=", value)
    else
      write_attribute(attr_name, value)
    end
  end

  private

  def virtual_attrs
    self.class.virtual_attr_names
  end
end