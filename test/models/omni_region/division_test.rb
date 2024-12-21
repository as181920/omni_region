require "test_helper"

module OmniRegion
  class DivisionTest < ActiveSupport::TestCase
    test "should create division" do
      Division.find_by(code: "156")&.destroy

      division = Division.new \
        type: "OmniRegion::Country",
        code: 156,
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
