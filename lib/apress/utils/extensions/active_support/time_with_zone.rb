# frozen_string_literal: true
require 'apress/utils/extensions/active_support/json/encoding'

module ActiveSupport
  class TimeWithZone
    def as_json(options = nil)
      if ActiveSupport::JSON::Encoding.use_standard_json_time_format
        xmlschema(ActiveSupport::JSON::Encoding.time_precision)
      else
        %(#{time.strftime("%Y/%m/%d %H:%M:%S")} #{formatted_offset(false)})
      end
    end
  end
end
