$:.push File.expand_path("lib", __dir__)

require "omni_region/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "omni_region"
  spec.version     = OmniRegion::VERSION
  spec.authors     = ["Andersen Fan"]
  spec.email       = ["as181920@gmail.com"]
  spec.homepage    = ""
  spec.summary     = "Region data"
  spec.description = "all regions as countries, provinces, districts, streets, and so on"
  spec.license     = "MIT"

  spec.metadata["allowed_push_host"] = "https://gems.dd-life.com"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.1"
  spec.add_dependency "jbuilder"
  spec.add_dependency "ransack"
  spec.add_dependency "rgeo"
  spec.add_dependency "rgeo-geojson"
end
