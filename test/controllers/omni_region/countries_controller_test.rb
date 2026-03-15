require "test_helper"

module OmniRegion
  class CountriesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index as json" do
      get countries_path(format: :json)

      assert_response :success
      assert_equal "application/json", @response.media_type
    end

    test "should render countries with code and name" do
      get countries_path(format: :json)

      country_china = omni_region_divisions(:country_china)
      country = @response.parsed_body.find { |item| item["code"] == country_china.code }

      assert_equal country_china.name, country["name"]
    end

    test "should accept blank q param" do
      get countries_path(format: :json), params: { q: "" }

      assert_response :success
    end
  end
end
