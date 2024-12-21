require "test_helper"

module OmniRegion
  class GeoJson::DistrictTest < ActiveSupport::TestCase
    test "should find by coordinate" do
      result = GeoJson::District.find_by(longitude: 121.232766, latitude: 31.054011)

      assert_not_empty result
      assert_equal "松江区", result[:district]
      assert_equal "310117", result[:division_code]
    end

    test "should return empty hash when not found" do
      result = GeoJson::District.find_by(longitude: 80, latitude: 30)

      assert_empty result
    end
  end
end
