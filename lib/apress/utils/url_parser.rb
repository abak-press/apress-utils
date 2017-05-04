module Apress
  module Utils
    module UrlParser
      URL_SCHEME_INDEX = 1
      URL_HOST_INDEX = 2
      URL_PORT_INDEX = 3
      URL_PATH_INDEX = 4
      URL_QUERY_INDEX = 5
      URL_PARSE_REGEXP = %r{([^?]*(?:\A|//|@))?([^:/?#]+)?(:\d+)?(/[^?#]*)?(.*?)\Z}

      class << self
        def extract_parts(url)
          match = url.match(URL_PARSE_REGEXP)
          match ? match.to_a : nil
        end

        def make_url(parts)
          result = ''
          return result unless parts

          result << (parts[URL_SCHEME_INDEX] || '')
          result << (parts[URL_HOST_INDEX]   || '')
          result << (parts[URL_PORT_INDEX]   || '')
          result << (parts[URL_PATH_INDEX]   || '')
          result << (parts[URL_QUERY_INDEX]  || '')
          result
        end

        def extract_part(url, part)
          parts = extract_parts(url)
          parts && parts[part]
        end

        def extract_scheme(url)
          extract_part(url, URL_SCHEME_INDEX)
        end

        def extract_host(url)
          extract_part(url, URL_HOST_INDEX)
        end

        def extract_port(url)
          extract_part(url, URL_PORT_INDEX)
        end

        def extract_path(url)
          extract_part(url, URL_PATH_INDEX)
        end

        def extract_query(url)
          extract_part(url, URL_QUERY_INDEX)
        end

        def get_scheme(parts)
          parts[URL_SCHEME_INDEX]
        end

        def get_host(parts)
          parts[URL_HOST_INDEX]
        end

        def get_port(parts)
          parts[URL_PORT_INDEX]
        end

        def get_path(parts)
          parts[URL_PATH_INDEX]
        end

        def get_query(parts)
          parts[URL_QUERY_INDEX]
        end

        def set_scheme(parts, scheme)
          parts[URL_SCHEME_INDEX] = scheme
          parts
        end

        def set_host(parts, host)
          parts[URL_HOST_INDEX] = host
          parts
        end

        def set_port(parts, port)
          parts[URL_PORT_INDEX] = port
          parts
        end

        def set_path(parts, path)
          parts[URL_PATH_INDEX] = path
          parts
        end

        def set_query(parts, query)
          parts[URL_QUERY_INDEX] = query
          parts
        end
      end
    end
  end
end