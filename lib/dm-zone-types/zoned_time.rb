# encoding: utf-8
require 'dm-zone-types'

module DataMapper
  class Property
    class ZonedTime < Time
      include DataMapper::Zone::Types

      def valid?(value)
        value.kind_of?(::Time) || value.nil?
      end

      def load(value)
        value.nil? ? nil : value.in_time_zone(::Time.zone)
      end

      def dump(value)
        return nil unless value
        time_with_zone_to_primitive value.in_time_zone(DataMapper::Zone::Types.storage_zone)
      end

      def typecast(value)
        case value
        when ::String
          ::Time.zone.parse(value)
        when ::DateTime
          value.in_time_zone
        when ::Time
          value.in_time_zone
        when ::Date
          value.to_time.in_time_zone
        when ActiveSupport::TimeWithZone
          value.in_time_zone
        when NilClass
          nil
        end
      end

      private
      def time_with_zone_to_primitive(value)
        value.to_datetime.to_time
      end
    end
  end
end

