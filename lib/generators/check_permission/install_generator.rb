require 'rails/generators/base'
require 'securerandom'
module CheckPermission	
	class InstallGenerator < Rails::Generators::Base
		source_root File.expand_path("../templates", __FILE__)
		class_option :orm
		def create_initializer_file
			create_file Rails.root.join("config", "initializers", "permission.rb"), "#::Permission_for = [Page, Category]"
		end

		def create_helper
			create_file Rails.root.join("app", "helpers", "permissions_helper.rb"), "
			module PermissionsHelper
				include CheckPermission
				def has_permission		
					super(params)
				end
			end
			"
		end
	end	
end