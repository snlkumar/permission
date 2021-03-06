require 'rails/generators/named_base'
module CheckPermission
	module Generators
		class CheckPermissionGenerator < Rails::Generators::NamedBase
			include Rails::Generators::ResourceHelpers			
			namespace "check_permission"			
			source_root File.expand_path("../templates", __FILE__)
			desc "Generates a model with the given NAME (if one does not exist) with permission " <<
			"configuration plus a migration file."
			hook_for :orm
			class_option :routes, desc: "Generate routes", type: :boolean, default: true				
		end
	end
end