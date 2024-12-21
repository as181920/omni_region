module OmniRegion
  module CoordinateTransformer
    class Gcj02Coordinate < BaseCoordinate
      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Lint/AmbiguousOperatorPrecedence
      def to_wgs84
        return { longitude:, latitude: } if out_of_china?

        # 计算偏移
        d_lat = transform_lat(longitude - 105.0, latitude - 35.0)
        d_lng = transform_lng(longitude - 105.0, latitude - 35.0)
        rad_lat = latitude / 180.0 * Math::PI
        magic = Math.sin(rad_lat)
        magic = 1 - OFFSET * magic * magic
        sqrt_magic = Math.sqrt(magic)
        d_lat = (d_lat * 180.0) / ((AXIS * (1 - OFFSET)) / (magic * sqrt_magic) * Math::PI)
        d_lng = (d_lng * 180.0) / (AXIS / sqrt_magic * Math.cos(rad_lat) * Math::PI)

        # 还原 CGCS2000 坐标
        mg_lat = latitude - d_lat
        mg_lng = longitude - d_lng
        { longitude: mg_lng, latitude: mg_lat }
      end
      alias_method :to_cgcs2000, :to_wgs84
      # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Lint/AmbiguousOperatorPrecedence
    end
  end
end
