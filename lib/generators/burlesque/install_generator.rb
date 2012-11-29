require 'rails/generators/migration'

module Burlesque
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      def generate_models
        copy_model_and_migration 'role'
        copy_model_and_migration 'authorization'
      end

      def copy_model_and_migration name
        _model_name = name
        _table_name = name.pluralize

        # Crea el modelo
        copy_file           "#{_model_name}.rb",        "app/models/#{_model_name}.rb"
        # Crea la tabla del modelo
        migration_template  "create_#{_table_name}.rb", "db/migrate/create_#{_table_name}.rb"
      end


      def self.next_migration_number path
        # unless @prev_migration_nr
        #   @prev_migration_nr = Dir.glob("#{Rails.root}/db/migrate/[0-9]*_*.rb").inject(0) do |max, file_path|
        #     n = File.basename(file_path).split('_', 2).first.to_i
        #     if n > max then n else max end
        #   end
        # else
        #   @prev_migration_nr += 1
        # end

        # ActiveRecord::Migration.new.next_migration_number(@prev_migration_nr.to_s)

        next_migration_number = current_migration_number(path) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end
    end
  end
end