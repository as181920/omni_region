module OmniRegion
  module GeoJson
    class District < Base
      Scope = RGeo::GeoJSON.decode \
        File.read(File.expand_path("../../../../lib/data/cn_districts.geojson", __dir__)),
        geo_factory: RGeo::Cartesian.preferred_factory
    end
  end
end
