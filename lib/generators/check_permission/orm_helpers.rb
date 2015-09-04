module CheckPermission
	module Generators
		module OrmHelpers			
			def model_contents
				buffer = <<-CONTENT
				# Add has_many here for the permission for.
				has_many :permissions
				accepts_nested_attributes_for :permissions
				CONTENT
				buffer += <<-CONTENT
				# Setup accessible (or protected) attributes for your model				
				CONTENT
				buffer
			end
			private
			def permission_model_exists?
				File.exists?(File.join(destination_root, permission_model_path))
			end

			def model_exists?
				File.exists?(File.join(destination_root, model_path))
			end

			def migration_exists?(table_name)
				Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_#{table_name}.rb$/).first
			end
			def migration_path
				@migration_path ||= File.join("db", "migrate")
			end
			def model_path
				@model_path ||= File.join("app", "models", "#{file_path}.rb")
			end	

			def permission_model_path
				@permission_model_path ||= File.join("app", "models", "permission.rb")
			end					
		end
	end
end