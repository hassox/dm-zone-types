require 'dm-zone-types/version'

require 'active_support/core_ext/time/zones'
require 'active_support/core_ext/time/calculations'
require 'active_support/core_ext/time/conversions'

require 'active_support/core_ext/date_time/zones'
require 'active_support/core_ext/date_time/calculations'
require 'active_support/core_ext/date_time/conversions'

require 'active_support/core_ext/date/conversions'

require 'dm-core'

module DataMapper
  module Zone
    module Types
      def self.storage_zone
        @storage_zone ||= ActiveSupport::TimeZone["UTC"]
      end

      def self.storage_zone=(zone)
        @storage_zone = ActiveSupport::TimeZone[zone]
      end
    end
  end

  class Property
    autoload :ZonedTime,        'dm-zone-types/zoned_time'
  end
end


# For chronic
# Time.use_zone("Wellington"){ Time.zone.parse(t.strftime("%Y-%m-%d %H:%M:%S")) }
