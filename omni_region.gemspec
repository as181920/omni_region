require_relative "lib/omni_region/version"

Gem::Specification.new do |spec|
  spec.name        = "omni_region"
  spec.version     = OmniRegion::VERSION
  spec.authors     = ["Andersen Fan"]
  spec.email       = ["as181920@gmail.com"]
  spec.homepage    = "https://gitlab.dd-life.com/shared/omni_region"
  spec.summary     = "Region data"
  spec.description = "all regions as countries, provinces, districts, streets, and so on"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["allowed_push_host"] = "https://gems.dd-life.com"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://gitlab.dd-life.com/shared/omni_region"
  spec.metadata["changelog_uri"] = "https://gitlab.dd-life.com/shared/omni_region"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "jbuilder"
  spec.add_dependency "rails", ">= 6.1"
  spec.add_dependency "ransack"
  spec.add_dependency "rgeo"
  spec.add_dependency "rgeo-geojson"
end
