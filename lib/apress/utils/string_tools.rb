# coding: utf-8
module Apress
  module Utils
    module StringTools
      module CharDet
        # Возвращает true если строка содержит допустимую
        # последовательность байтов для кодировки utf8 и false в обратном случае
        # см. http://en.wikipedia.org/wiki/UTF-8
        def valid_utf8? string
          case string
          when String then string.is_utf8?
          else false
          end
        end

        # shorthand
        def detect_encoding(str)
          str.detect_encoding
        end

        # привести строку к utf8
        def to_utf8(str)
          str.to_utf8
        end

        def to_cp1251(str)
          str.to_cp1251
        end

        def cp1251_compatible_encodings
          [
            'windows-1253',
            'windows-1254',
            'windows-1255',
            'windows-1256',
            'windows-1258',
            'EUC-TW',
            'ISO-8859-8' # очередная еврейская кодировка
          ]
        end
      end
      extend CharDet

      module WordProcessing
        # Обрезает строку по словам.
        def truncate_words(text, length = 75)
          return if text.nil?

          if text.mb_chars.size > length
            new_length = text.mb_chars[0...length].rindex(/[^[:word:]]/)
            text.mb_chars[0...new_length.to_i]
          else
            text
          end
        rescue
          text[0...length]
        end
      end
      extend WordProcessing

      module ActionControllerExtension
        def accepts_non_utf8_params(*args)
          args.each do |arg|
            next unless arg.is_a?(Symbol) || arg.is_a?(String)
            arg = arg.to_sym

            class_eval do
              before_filter { |controller|
                decode = lambda { |s|
                  if s.is_a?(Hash)
                    s.to_a.map { |k, v| [k, Apress::Utils::StringTools.to_utf8(v)] }.to_hash
                  elsif s.is_a?(Array)
                    s.map { |v| Apress::Utils::StringTools.to_utf8(v) }
                  else
                    Apress::Utils::StringTools.to_utf8(s)
                  end
                }

                controller.params[arg] = decode.call(controller.params[arg]) unless controller.params[arg].nil?
              }
            end
          end
        end

        alias_method :accepts_non_utf8_param, :accepts_non_utf8_params
      end

      module Sanitizing
        def sanitize(text, options = {})
          sanitizer = options.delete(:sanitizer)
          sanitizer = Apress::Utils::StringTools::Sanitizer::Base.new unless sanitizer.respond_to?(:sanitize)
          sanitizer.sanitize(text, options)
        end

        # Public: вычищает ASCII Control Characters из строки
        #
        # string - String строка, из которой удаляем символы
        #
        # Returns String
        def clear_control_characters(string)
          string.tr("\u0000-\u001f", '')
        end
      end
      extend Sanitizing

      module Sanitizer
        class Base
          require 'sanitize'

          TAGS_WITH_ATTRIBUTES = {
              'p'     => ['align', 'style'],
              'div'   => ['align', 'style'],
              'span'  => ['align', 'style'],
              'td'    => ['align', 'width', 'valign', 'colspan', 'rowspan', 'style'],
              'th'    => ['align', 'width', 'valign', 'colspan', 'rowspan', 'style'],
              'a'     => ['href', 'target', 'name', 'style'],
              'table' => ['cellpadding', 'cellspacing', 'width', 'border', 'align', 'style'],
              'img'   => ['src', 'width', 'height', 'style']
          }

          TAGS_WITHOUT_ATTRIBUTES = ['b','strong', 'i', 'em', 'sup', 'sub', 'ul', 'ol', 'li', 'blockquote', 'br', 'tr', 'u', 'caption', 'thead']

          def sanitize(str, attr = {})
            # для корректного обрезания utf строчек режем через mb_chars
            # для защиты от перегрузки парсера пропускаем максимум 1 мегабайт текста
            # длина русского символа в utf-8 - 2 байта, 1Мб/2б = 524288 = 2**19 символов
            # длина по символам с перестраховкой, т.к. латинские символы(теги, например) занимают 1 байт
            str = str.mb_chars.slice(0..(2**19)).to_s

            attributes = TAGS_WITH_ATTRIBUTES

            # Мерджим добавочные теги и атрибуты
            attributes.merge!(attr)
            elements = attributes.keys | TAGS_WITHOUT_ATTRIBUTES

            Sanitize.clean!(str,
                            :attributes => attributes,
                            :elements => elements,
                            :remove_contents => ['style', 'javascript'],
                            :allow_comments => false
            )

            #Почему-то при первой очистке все что внутри style как комментарий экскейпится и остается. Поэтому делаем unescape и чистим повторно, чтобы наверняка
            str = CGI::unescapeHTML(str)
            str = str.slice(0..50*1024) #Пропускаем максимум 50 кбайт.

            Sanitize.clean(str,
                           :attributes => attributes,
                           :elements => elements,
                           :remove_contents => ['style', 'javascript'],
                           :allow_comments => false
            )
          end
        end
      end

      module SumInWords
        require 'ru_propisju'

        # Сумма в рублях прописью. Кол-во копеек выводится всегда. Первая буква заглавная
        def rublej_propisju(amount)
          kop = (amount.divmod(1)[1]*100).round
          result = RuPropisju.rublej(amount.to_i).capitalize
          result << " %.2d " % kop
          result << RuPropisju.choose_plural(kop, 'копейка', 'копейки', 'копеек')
        end
      end
      extend SumInWords
    end
  end
end
