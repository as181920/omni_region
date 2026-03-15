require "test_helper"
require "securerandom"

module OmniRegion
  class DivisionTest < ActiveSupport::TestCase
    test "should create division" do
      division = Division.new \
        type: "OmniRegion::Country",
        code: "test_#{SecureRandom.hex(4)}",
        name: "China"

      assert division.save
      assert_equal "China", division.to_s
    end

    test "should not create with same code" do
      division = Division.new \
        type: "OmniRegion::Country",
        code: 156,
        name: "China"

      assert_not division.save
      assert_includes division.errors[:code], I18n.t("errors.messages.taken")
    end
  end
end
