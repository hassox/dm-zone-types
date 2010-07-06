# encoding: utf-8
require 'dm-zone-types'

module DataMapper
  class Property
    class ZonedTime < Time
      include DataMapper::Zone::Types

      def valid?(value, negated = false)
        response = value.kind_of?(::Time) || value.nil? || value.kind_of?(::Range)
        negated ? !response : response
      end

      def load(value)
        value.nil? ? nil : value.in_time_zone(::Time.zone)
      end

      def dump(value)
        return nil unless value
        zone = DataMapper::Zone::Types.storage_zone
        if value.respond_to?(:in_time_zone)
          time_with_zone_to_primitive value.in_time_zone(zone)
        elsif ::Range === value
          if value.first.respond_to?(:in_time_zone) && value.last.respond_to?(:in_time_zone)
            ((time_with_zone_to_primitive(value.first.in_time_zone(zone)))..(time_with_zone_to_primitive(value.last.in_time_zone(zone))))
          else
            value
          end
        else
          value
        end
      end

      def typecast(value)
        case value
        when ::String
          ::Time.zone.parse(value)
        when ::Date
          value.to_time.in_time_zone
        else
          value.respond_to?(:in_time_zone) ? value.in_time_zone : value
        end
      end

      private
      def time_with_zone_to_primitive(value)
        value.to_datetime.to_time
      end
    end
  end
end

