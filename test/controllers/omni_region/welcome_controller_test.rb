require "test_helper"

module OmniRegion
  class WelcomeControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get welcome_index_url

      assert_response :success
      assert_equal I18n.t("omni_region.engine"), @response.parsed_body.at("title").content
      assert_includes @response.body, I18n.t("omni_region.welcome")
    end
  end
end
