require "test_helper"

module OmniRegion
  class ApiDocsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get docs index" do
      get api_docs_path

      assert_response :success
      assert_includes @response.body, "OmniRegion API Docs"
    end

    test "should get openapi spec" do
      get openapi_spec_path

      assert_response :success
      assert_equal "application/json", @response.media_type
    end

    test "should get nested openapi file" do
      get openapi_spec_file_path(path: "components/schemas/division", format: :json)

      assert_response :success
      assert_equal "application/json", @response.media_type
    end

    test "should get division detail schema file" do
      get openapi_spec_file_path(path: "components/schemas/division_detail", format: :json)

      assert_response :success
      assert_equal "application/json", @response.media_type
    end

    test "should reject path traversal" do
      get openapi_spec_file_path(path: "../database", format: :yml)

      assert_response :not_found
    end
  end
end
