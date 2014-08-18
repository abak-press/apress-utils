# coding: utf-8

# Public: Содержит регулярное выражение необходимое для валидации email.
module Apress
  module Utils
    module EmailValidation
      EMAIL_REGEXP = /\A[a-z0-9\-_]+(?:\.[a-z0-9\-\._]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\Z/i.freeze

      def self.regexp
        EMAIL_REGEXP
      end
    end
  end
end
