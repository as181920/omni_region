require "test_helper"

module OmniRegion
  class CoordinateTransformer::Bd09CoordinateTest < ActiveSupport::TestCase
    test "converts a known Baidu point to GCJ02" do
      result = CoordinateTransformer::Bd09Coordinate.new(longitude: 116.41036949371029, latitude: 39.92133699351021).to_gcj02

      assert_in_delta 116.404, result[:longitude], 2e-6
      assert_in_delta 39.915, result[:latitude], 2e-6
    end
  end
end
