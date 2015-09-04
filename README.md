# CheckPermission

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/check_permission`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'check_permission'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install check_permission

## Usage

	rails g check_permission:install

	It will create the permission.rb . Define the model in permission.rb, applying the permission for
	::Permission_for = [Post]
    
    rails g check_permission User

    It will create the migrations for the user and permission and it will create the models for the same.

    Create form for assinging the permissions.
    in UsersController

    def new
    	@user = User.new
    	Permission_for.each do |model|
    		@user.permissions.build(resource_name: model)
    	end
    end

    In _form.html.erb

    <%= form_for @user do |f|%
    	--	stuff --
	    <%= f.fields_for :permissions do |p|%>    
	      <tr>
	        <%=p.hidden_field :resource_name%>
	        <td><%=p.object.resource_name%></td>
	        <td><%=p.check_box :is_read%></td>
	        <td><%=p.check_box :is_create%></td>
	        <td><%=p.check_box :is_update%></td>
	        <td><%=p.check_box :is_destroy%></td>

	      </tr>
	  	<% end %>
	<%end%

	Call in controller or view has_permission

	def edit
		-- do stuff --
	end if has_permission

	has_permission work with current_user (logged_in) only.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/check_permission.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

