module OmniRegion
  module CoordinateTransformer
    class BaseCoordinate
      attr_reader :longitude, :latitude

      def initialize(longitude: nil, latitude: nil)
        @longitude = longitude
        @latitude = latitude
      end
    end
  end
end
