module CheckPermission
	module Generators
		module OrmHelpers		
			p "orm helper"	
			def model_contents
				buffer = <<-CONTENT
				# Add has_many here for the permission for.
				has_many :permissions
				CONTENT
				buffer += <<-CONTENT
				# Setup accessible (or protected) attributes for your model				
				CONTENT
				buffer
			end

			def permission_model_contents
				buffer = <<-CONTENT
				# Add belongs_to here for the permission for.
				belongs_to :user
				CONTENT
				buffer += <<-CONTENT
				# Setup accessible (or protected) attributes for your model				
				CONTENT
				buffer
			end
			# # def needs_attr_accessible?
			# # 	rails_3? && !strong_parameters_enabled?
			# # end
			# # def rails_3?
			# # 	Rails::VERSION::MAJOR == 3
			# # end
			# # def strong_parameters_enabled?
			# # 	defined?(ActionController::StrongParameters)
			# # end

			private
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
				@model_path ||= File.join("app", "models", "permission.rb")
			end		
			p "end helper"
		end
	end
end