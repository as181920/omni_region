# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_paths=)
  ActiveSupport::TestCase.fixture_paths = [File.expand_path("fixtures", __dir__)]
  ActionDispatch::IntegrationTest.fixture_paths = ActiveSupport::TestCase.fixture_paths
  ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures/files", __dir__)
  ActiveStorage::FixtureSet.file_fixture_path = ActiveSupport::TestCase.file_fixture_path
  ActiveSupport::TestCase.fixtures :all
end

require "minitest/mock"
require "mocha/minitest"
require "webmock/minitest"
require "debug"

require "minitest/reporters"
Minitest::Reporters.use!

ActiveRecord.verify_foreign_keys_for_fixtures = false # Temporarily handle RuntimeError: Foreign key violations found in your fixture data.
