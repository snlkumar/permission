require 'rails/generators/active_record'
require 'generators/check_permission/orm_helpers'
module ActiveRecord
	module Generators
		class CheckPermissionGenerator < ActiveRecord::Generators::Base			
			argument :attributes, type: :array, default: [], banner: "field:type field:type"
			include CheckPermission::Generators::OrmHelpers
			source_root File.expand_path("../templates", __FILE__)
			def copy_permission_migration				
				if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
					# migration_template "migration_existing.rb", "db/migrate/add_permission_to_#{table_name}.rb"
				else
					migration_template "migration.rb", "db/migrate/permission_create_#{table_name}.rb"
				end
			end
			def generate_model
					invoke "active_record:model", [name], migration: false unless model_exists? && behavior == :invoke								
			end

			def generate_model_permission				
				permission = "Permission"
				Rails::Generators.invoke("active_record:model", [permission,"is_read:boolean", "is_update:boolean", 
					"is_create:boolean", "is_destroy:boolean", "resource_name:string", "#{table_name.singularize}:references"], {migration: true, timestamps: true})				
			end

			def generate_view
				create_file Rails.root.join("app", "views", "permissions", "_permissions.html.rb"), "#{partial_content}"		
			end unless permission_view_exists?

			def generate_helper
				create_file Rails.root.join("app", "helpers", "permissions_helper.rb"), "
				module PermissionsHelper
					include CheckPermission
					def has_permission		
						super(params)
					end
				end
				"
			end unless permissions_helper_exists?

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

			def migration_data
<<RUBY				
				t.string :email
				t.string :name		
RUBY
			end			
		end	
	end
end