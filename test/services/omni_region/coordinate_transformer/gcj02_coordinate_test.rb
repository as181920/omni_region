require "test_helper"

module OmniRegion
  class CoordinateTransformer::Gcj02CoordinateTest < ActiveSupport::TestCase
    test "should transform to wgs84" do
      result = CoordinateTransformer::Gcj02Coordinate.new(longitude: 116.41024449916938, latitude: 39.91640428150164).to_wgs84

      assert_not_empty result
      assert_in_delta 116.404, result[:longitude], 1e-8
      assert_in_delta 39.915, result[:latitude], 1e-8
    end

    test "converts a known GCJ02 point to Baidu longitude and latitude" do
      result = CoordinateTransformer::Gcj02Coordinate.new(longitude: 116.404, latitude: 39.915).to_bd09

      assert_in_delta 116.41036949371029, result[:longitude], 1e-9
      assert_in_delta 39.92133699351021, result[:latitude], 1e-9
    end

    test "keeps coordinates outside the GCJ02 adjustment region unchanged" do
      point = { longitude: -0.1276, latitude: 51.5072 }

      assert_equal point, CoordinateTransformer::Gcj02Coordinate.new(**point).to_wgs84
    end

    test "should handle string input" do
      coord = CoordinateTransformer::Gcj02Coordinate.new(longitude: "121.232766", latitude: "31.054011")

      assert_predicate coord, :in_china?
    end
  end
end
