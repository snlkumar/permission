require 'rails/generators/base'
require 'securerandom'
module CheckPermission	
	class InstallGenerator < Rails::Generators::Base
		source_root File.expand_path("../templates", __FILE__)
		class_option :orm
		def create_initializer_file
			create_file Rails.root.join("config", "initializers", "permission.rb"), "#::Permission_for = [Page, Category]"
		end
	end	
end