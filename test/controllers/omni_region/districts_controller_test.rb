require "test_helper"

module OmniRegion
  class DistrictsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index as json" do
      get districts_path(format: :json)

      assert_response :success
      assert_equal "application/json", @response.media_type
    end

    test "should render districts with code and name" do
      get districts_path(format: :json)

      district_xuanwu = omni_region_divisions(:district_xuanwu)
      district = @response.parsed_body.find { |item| item["code"] == district_xuanwu.code }

      assert_equal district_xuanwu.name, district["name"]
    end

    test "should filter districts by code" do
      district_xuanwu = omni_region_divisions(:district_xuanwu)
      get districts_path(format: :json), params: { q: { code_eq: district_xuanwu.code } }

      codes = @response.parsed_body.map { |item| item["code"] }

      assert_equal [district_xuanwu.code], codes
    end

    test "should filter districts by parent city code" do
      city_nanjing = omni_region_divisions(:city_nanjing)
      district_xuanwu = omni_region_divisions(:district_xuanwu)
      get districts_path(format: :json), params: { q: { parent_code_eq: city_nanjing.code } }

      codes = @response.parsed_body.map { |item| item["code"] }

      assert_equal [district_xuanwu.code], codes
    end
  end
end
