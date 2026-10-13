require "test_helper"

module OmniRegion
  class CoordinateTransformerTest < ActiveSupport::TestCase
    [nil, "bad", Float::NAN, Float::INFINITY, 181].each do |value|
      test "rejects invalid longitude #{value.inspect}" do
        assert_raises(ArgumentError) do
          CoordinateTransformer::Gcj02Coordinate.new(longitude: value, latitude: 31)
        end
      end
    end

    test "rejects latitude beyond the valid range" do
      assert_raises(ArgumentError) do
        CoordinateTransformer::Gcj02Coordinate.new(longitude: 121, latitude: 91)
      end
    end

    test "accepts a legitimate zero coordinate" do
      result = CoordinateTransformer::Gcj02Coordinate.new(longitude: 0, latitude: 0).to_wgs84

      assert_equal({ longitude: 0.0, latitude: 0.0 }, result)
    end

    test "should define namespace" do
      assert_kind_of Module, CoordinateTransformer
    end
  end
end
