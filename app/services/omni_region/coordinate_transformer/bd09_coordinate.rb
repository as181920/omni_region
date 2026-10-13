module OmniRegion
  module CoordinateTransformer
    class Bd09Coordinate < BaseCoordinate
      def to_gcj02
        lng, lat = longitude - 0.0065, latitude - 0.006
        radius = Math.hypot(lng, lat) - 0.00002 * Math.sin(lat * Gcj02Coordinate::BD_FACTOR)
        angle = Math.atan2(lat, lng) - 0.000003 * Math.cos(lng * Gcj02Coordinate::BD_FACTOR)
        { longitude: radius * Math.cos(angle), latitude: radius * Math.sin(angle) }
      end
    end
  end
end
