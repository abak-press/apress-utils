# frozen_string_literal: true

# Public: Содержит регулярное выражение необходимое для валидации email.
module Apress
  module Utils
    module EmailValidation
      EMAIL_REGEXP = /\A[a-zа-яё0-9\-_]+(?:\.[a-zа-яё0-9\-\._]+)*@
        (?:[a-zа-яё0-9](?:[a-zа-яё0-9-]*[a-zа-яё0-9])?\.)+
        [a-zа-яё0-9](?:[a-zа-яё0-9-]*[a-zа-яё0-9])?\Z/ix.freeze

      def regexp
        EMAIL_REGEXP
      end
      module_function :regexp
    end
  end
end
