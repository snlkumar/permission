class PermissionCreate < ActiveRecord::Migration
	def change
		create_table :permissions do |t|
			<%= permission_migration_data -%>
			<% attributes.each do |attribute| -%>
			t.<%= attribute.type %> :<%= attribute.name %>
			<% end -%>
			t.timestamps null: false
		end	
	end
end