module OmniRegion
  module CoordinateTransformer
    class BaseCoordinate
      AXIS = 6378245.0
      OFFSET = 0.00669342162296594323

      attr_reader :longitude, :latitude

      def initialize(longitude:, latitude:)
        @longitude = parse_coordinate(longitude, -180..180)
        @latitude = parse_coordinate(latitude, -90..90)
      end

      def out_of_china?
        longitude < 72.004 || longitude > 137.8347 || latitude < 0.8293 || latitude > 55.8271
      end

      def in_china?
        !out_of_china?
      end

      # rubocop:disable Metrics/AbcSize, Lint/AmbiguousOperatorPrecedence
      private

        def parse_coordinate(value, range)
          number = Float(value, exception: false)
          raise ArgumentError, "Invalid coordinate: #{value.inspect}" unless number&.finite? && range.cover?(number)

          number
        end

        def offsets
          d_lat = transform_lat(longitude - 105.0, latitude - 35.0)
          d_lng = transform_lng(longitude - 105.0, latitude - 35.0)
          rad_lat = latitude / 180.0 * Math::PI
          magic = 1 - OFFSET * Math.sin(rad_lat)**2
          sqrt_magic = Math.sqrt(magic)
          d_lat = (d_lat * 180.0) / ((AXIS * (1 - OFFSET)) / (magic * sqrt_magic) * Math::PI)
          d_lng = (d_lng * 180.0) / (AXIS / sqrt_magic * Math.cos(rad_lat) * Math::PI)
          [d_lng, d_lat]
        end

        def transform_lat(lng, lat)
          ret = -100.0 + 2.0 * lng + 3.0 * lat + 0.2 * lat * lat + 0.1 * lng * lat + 0.2 * Math.sqrt(lng.abs)
          ret += (20.0 * Math.sin(6.0 * lng * Math::PI) + 20.0 * Math.sin(2.0 * lng * Math::PI)) * 2.0 / 3.0
          ret += (20.0 * Math.sin(lat * Math::PI) + 40.0 * Math.sin(lat / 3.0 * Math::PI)) * 2.0 / 3.0
          ret += (160.0 * Math.sin(lat / 12.0 * Math::PI) + 320.0 * Math.sin(lat * Math::PI / 30.0)) * 2.0 / 3.0
          ret
        end

        def transform_lng(lng, lat)
          ret = 300.0 + lng + 2.0 * lat + 0.1 * lng * lng + 0.1 * lng * lat + 0.1 * Math.sqrt(lng.abs)
          ret += (20.0 * Math.sin(6.0 * lng * Math::PI) + 20.0 * Math.sin(2.0 * lng * Math::PI)) * 2.0 / 3.0
          ret += (20.0 * Math.sin(lng * Math::PI) + 40.0 * Math.sin(lng / 3.0 * Math::PI)) * 2.0 / 3.0
          ret += (150.0 * Math.sin(lng / 12.0 * Math::PI) + 300.0 * Math.sin(lng / 30.0 * Math::PI)) * 2.0 / 3.0
          ret
        end
      # rubocop:enable Metrics/AbcSize, Lint/AmbiguousOperatorPrecedence
    end
  end
end
