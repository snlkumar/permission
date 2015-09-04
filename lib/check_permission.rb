require "check_permission/version"

module CheckPermission
   def has_permission params
   		p "in check permission with #{params}"
		resource = params[:controller].singularize.camelize
		action = params[:action]
		begin
			permission = current_user.permissions			
		rescue
			return raise "current_user is nil"
		else
			return result permission, resource, action
		end		
	end

	private

	def result permission, resource, action		
		permission = current_user.permissions.where(resource_name: resource).last
		return false if permission.nil?
		case action.to_sym			
		when :index, :show
			return permission.is_read		
		when :create, :new
			return permission.is_create				
		when :update, :edit			
			return permission.is_update			 
		when :destroy, :delete			
			return permission.is_destroy		
		else
			return false
		end
	end
end
