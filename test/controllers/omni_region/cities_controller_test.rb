require "test_helper"

module OmniRegion
  class CitiesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index as json" do
      get cities_path(format: :json)

      assert_response :success
      assert_equal "application/json", @response.media_type
    end

    test "should render cities with code and name" do
      get cities_path(format: :json)

      city_nanjing = omni_region_divisions(:city_nanjing)
      city = @response.parsed_body.find { |item| item["code"] == city_nanjing.code }

      assert_equal city_nanjing.name, city["name"]
    end

    test "should filter cities by code" do
      city_nanjing = omni_region_divisions(:city_nanjing)
      get cities_path(format: :json), params: { q: { code_eq: city_nanjing.code } }

      codes = @response.parsed_body.map { |item| item["code"] }

      assert_equal [city_nanjing.code], codes
    end

    test "should filter cities by parent province code" do
      province_jiangsu = omni_region_divisions(:province_jiangsu)
      city_nanjing = omni_region_divisions(:city_nanjing)
      city_suzhou = omni_region_divisions(:city_suzhou)
      city_hangzhou = omni_region_divisions(:city_hangzhou)
      get cities_path(format: :json), params: { q: { parent_code_eq: province_jiangsu.code } }

      codes = @response.parsed_body.map { |item| item["code"] }

      assert_includes codes, city_nanjing.code
      assert_includes codes, city_suzhou.code
      assert_not_includes codes, city_hangzhou.code
    end
  end
end
