require "check_permission/version"

module CheckPermission
   def has_permission
   		p "in check permission"
		# resource = params[:controller].singularize.camelize
		# action = params[:action]
		# begin
		# 	permission = current_user.permissions			
		# rescue
		# 	return raise "current_user is nil"
		# else
		# 	return result permission, resource
		# end		
	end

	# private

	# def result permission, resource		
		# permission = current_user.permissions.where(resource_name: resource).last
		# return false if permission.nil?
		# case action.to_sym			
		# when :index
		# 	return permission.read_only		
		# when :create
		# 	return permission.create_only				
		# when :update			
		# 	return permission.update_only				 
		# when :destroy, :delete			
		# 	return permission.destroy_only		
		# else
		# 	return false
		# end
	# end
end
