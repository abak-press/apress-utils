# coding: utf-8
module Apress
  module Utils
    class ProjectOverrideError < StandardError
      def message
        'Необходимо переопределить метод в проекте'
      end
    end
  end
end
