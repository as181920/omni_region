require "test_helper"

module OmniRegion
  class CoordinateTransformer::Gcj02CoordinateTest < ActiveSupport::TestCase
    test "should transform to wgs84" do
      result = CoordinateTransformer::Gcj02Coordinate.new(longitude: 121.232766, latitude: 31.054011).to_wgs84

      assert_not_empty result
      assert_in_delta 121.2283508849327, result[:longitude], 10**-5
      assert_in_delta 31.056121203746414, result[:latitude], 10**-5
    end

    test "should handle string input" do
      coord = CoordinateTransformer::Gcj02Coordinate.new(longitude: "121.232766", latitude: "31.054011")

      assert_predicate coord, :in_china?
    end
  end
end
