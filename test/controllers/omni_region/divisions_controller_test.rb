require "test_helper"

module OmniRegion
  class DivisionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get divisions_path

      country_china = omni_region_divisions(:country_china)

      assert_response :success
      assert_includes @response.body, country_china.name
    end

    test "should show division by code" do
      province_jiangsu = omni_region_divisions(:province_jiangsu)
      get division_path(province_jiangsu.code)

      assert_response :success
      assert_includes @response.body, province_jiangsu.code
    end
  end
end
