class UsersController< ApplicationController
  def index
    @all_users = User.all
    render({ :template => "users/index" })
  end
end
