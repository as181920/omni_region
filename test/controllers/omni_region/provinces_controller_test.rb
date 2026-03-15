require "test_helper"

module OmniRegion
  class ProvincesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index as json" do
      get provinces_path(format: :json)

      assert_response :success
      assert_equal "application/json", @response.media_type
    end

    test "should render provinces with code and name" do
      get provinces_path(format: :json)

      province_jiangsu = omni_region_divisions(:province_jiangsu)
      province = @response.parsed_body.find { |item| item["code"] == province_jiangsu.code }

      assert_equal province_jiangsu.name, province["name"]
    end

    test "should sort provinces by name asc by default" do
      get provinces_path(format: :json)

      names = @response.parsed_body.map { |item| item["name"] }

      assert_equal names.sort, names
    end
  end
end
