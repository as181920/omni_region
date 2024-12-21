require "test_helper"

module OmniRegion
  class GeoJson::CityTest < ActiveSupport::TestCase
    test "should find by coordinate" do
      result = GeoJson::City.find_by(longitude: 121.232766, latitude: 31.054011)

      assert_not_empty result
      assert_equal "上海市", result[:city]
      assert_equal "310000", result[:division_code]
    end
  end
end
