module OmniRegion
  module GeoJson
    class Province < Base
      Scope = RGeo::GeoJSON.decode \
        File.read(File.expand_path("../../../../lib/data/cn_provinces.geojson", __dir__)),
        geo_factory: RGeo::Cartesian.preferred_factory
    end
  end
end
