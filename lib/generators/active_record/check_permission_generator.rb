require 'rails/generators/active_record'
require 'generators/check_permission/orm_helpers'
module ActiveRecord
	module Generators
		class CheckPermissionGenerator < ActiveRecord::Generators::Base
			puts "start permission g"
			argument :attributes, type: :array, default: [], banner: "field:type field:type"
			include CheckPermission::Generators::OrmHelpers
			source_root File.expand_path("../templates", __FILE__)
			def copy_permission_migration
				puts "i am in copu"
				#custom code
					migration_template "permission_migration.rb", "db/migrate/create_permission.rb"
				#ciustom code
				if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
					migration_template "migration_existing.rb", "db/migrate/add_permission_to_#{table_name}.rb"
				else
					migration_template "migration.rb", "db/migrate/permission_create_#{table_name}.rb"
				end
			end
			def generate_model
				puts "i am in gmodel #{name} and #{model_exists?}"				
				invoke "active_record:model", [name], migration: false unless model_exists? && behavior == :invoke				
				generate_permission_model
			end

			def generate_permission_model
				per = "Permission"				
				invoke "active_record:model", [per], migration: false unless permission_model_exists? && behavior == :invoke
			end

			def inject_permission_content
				content = permission_model_contents
				class_path = if namespaced?
					class_name.to_s.split("::")
				else
					[class_name]
				end
				# indent_depth = class_path.size - 1
				# content = content.split("\n").map { |line| " " * indent_depth + line } .join("\n") << "\n"
				# inject_into_class(model_path, class_path.last, content) if model_exists?
				inject_into_class(permission_model_path, class_path.last, content)
			end

			def inject_permission_content
				content = model_contents
				class_path = if namespaced?
					class_name.to_s.split("::")
				else
					[class_name]
				end
				indent_depth = class_path.size - 1
				content = content.split("\n").map { |line| " " * indent_depth + line } .join("\n") << "\n"
				inject_into_class(model_path, class_path.last, content) if model_exists?				
			end
			def permission_migration_data
<<RUBY
				## Database authenticatable
					t.references :user
					t.boolean :is_read, default: false
					t.boolean :is_update, default: false
					t.boolean :is_create, default: false
					t.boolean :is_destroy, default: false
					t.string :resource_name, null: false			
RUBY
			end

			def migration_data
<<RUBY
				## Database authenticatable					
					t.string :email
					t.string :name		
RUBY
			end
			def ip_column
				# Padded with spaces so it aligns nicely with the rest of the columns.
				"%-8s" % (inet? ? "inet" : "string")
			end
			def inet?
				rails4? && postgresql?
			end
			def rails4?
				Rails.version.start_with? '4'
			end
			def postgresql?
				config = ActiveRecord::Base.configurations[Rails.env]
				config && config['adapter'] == 'postgresql'
			end
			puts "end of generator"
		end	
	end
end