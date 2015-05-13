require 'rails/generators'
require 'rails/generators/migration'

module Ipgeobase
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "Generates migration for Ipgeobase models"

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def create_ipgeobase_migration
        migration_template "migration.rb", File.join('db/migrate', "create_ipgeobase.rb")
      end

      protected
    end
  end
end

