$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://gems.io-note.cn"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.2"
  spec.add_dependency "jbuilder"
  spec.add_dependency "ransack"

  spec.add_development_dependency "sqlite3"
end
