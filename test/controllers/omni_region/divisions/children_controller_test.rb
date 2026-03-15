require "test_helper"

module OmniRegion
  class Divisions::ChildrenControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index as json" do
      province_jiangsu = omni_region_divisions(:province_jiangsu)
      get division_children_path(province_jiangsu.code, format: :json)

      assert_response :success
      assert_equal "application/json", @response.media_type
    end

    test "should render only direct children" do
      province_jiangsu = omni_region_divisions(:province_jiangsu)
      city_nanjing = omni_region_divisions(:city_nanjing)
      district_xuanwu = omni_region_divisions(:district_xuanwu)
      get division_children_path(province_jiangsu.code, format: :json)

      child_codes = @response.parsed_body.map { |item| item["code"] }

      assert_includes child_codes, city_nanjing.code
      assert_not_includes child_codes, district_xuanwu.code
    end
  end
end
