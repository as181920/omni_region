require "test_helper"

module OmniRegion
  class CoordinateTransformer::Wgs84CoordinateTest < ActiveSupport::TestCase
    test "should transform to gcj02" do
      result = CoordinateTransformer::Wgs84Coordinate.new(longitude: 121.232766, latitude: 31.054011).to_gcj02

      assert_not_empty result
      assert_in_delta 121.2371811150673, result[:longitude], 10**-5
      assert_in_delta 31.051900796253584, result[:latitude], 10**-5
    end
  end
end
