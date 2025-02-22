class UsersController< ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })
  def index
    @all_users = User.all
    render({ :template => "users/index" })
  end
end
