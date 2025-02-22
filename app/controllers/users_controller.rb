class UsersController< ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })
  def index
    @all_users = User.all
    render({ :template => "users/index" })
  end
  def show
    @the_user = User.where({ :username => params.fetch("username") }).at(0)
    if @the_user
      render({ :template => "users/show" })
    else
      redirect_to("/users", { :alert => "User not found." })
    end
  end
end
