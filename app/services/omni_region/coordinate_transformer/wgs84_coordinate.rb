module OmniRegion
  module CoordinateTransformer
    class Wgs84Coordinate < BaseCoordinate
      def to_gcj02
        return { longitude:, latitude: } if out_of_china?

        d_lng, d_lat = offsets
        { longitude: longitude + d_lng, latitude: latitude + d_lat }
      end
    end
  end
end
