require "test_helper"

module OmniRegion
  class CoordinateTransformerTest < ActiveSupport::TestCase
    test "should define namespace" do
      assert_kind_of Module, CoordinateTransformer
    end
  end
end
