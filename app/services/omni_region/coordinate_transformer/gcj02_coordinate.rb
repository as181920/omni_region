module OmniRegion
  module CoordinateTransformer
    class Gcj02Coordinate < BaseCoordinate
      TOLERANCE = 1e-9
      MAX_ITERATIONS = 20
      BD_FACTOR = Math::PI * 3000 / 180

      def to_wgs84
        return { longitude:, latitude: } if out_of_china?

        estimate = { longitude:, latitude: }
        MAX_ITERATIONS.times do
          projected = Wgs84Coordinate.new(**estimate).to_gcj02
          d_lng, d_lat = projected[:longitude] - longitude, projected[:latitude] - latitude
          return estimate if [d_lng.abs, d_lat.abs].max <= TOLERANCE

          estimate = { longitude: estimate[:longitude] - d_lng, latitude: estimate[:latitude] - d_lat }
        end
        raise ArgumentError, "Coordinate inverse conversion did not converge"
      end

      def to_bd09
        radius = Math.hypot(longitude, latitude) + 0.00002 * Math.sin(latitude * BD_FACTOR)
        angle = Math.atan2(latitude, longitude) + 0.000003 * Math.cos(longitude * BD_FACTOR)
        { longitude: radius * Math.cos(angle) + 0.0065, latitude: radius * Math.sin(angle) + 0.006 }
      end
    end
  end
end
