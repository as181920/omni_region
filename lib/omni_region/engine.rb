require "jbuilder"
require "ransack"
require "rgeo-geojson"

module OmniRegion
  class Engine < ::Rails::Engine
    isolate_namespace OmniRegion

    initializer :append_migrations do |app|
      unless app.root == root.join("test/dummy")
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.test_framework  :test_unit
      g.skip_routes     true
    end
  end
end
