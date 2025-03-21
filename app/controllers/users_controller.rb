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

  def create_follow_request
    @follow_request = FollowRequest.new
    @follow_request.sender_id = current_user.id
    @follow_request.recipient_id = params.fetch("query_recipient_id")

    recipient = User.where({:id => params.fetch("query_recipient_id")}).at(0)

    if recipient.private == true
      @follow_request.status = "pending"
    else
      @follow_request.status = "accepted"
    end

    if @follow_request.valid?
      @follow_request.save
      if recipient&.private?
        redirect_to("/", { :alert => "You're not authorized for that." })
      else
        redirect_to("/users/#{recipient.username}", { :notice => "Follow request sent." })
      end
    else
      redirect_to("/", { :alert => "Unable to send follow request." })
    end
  end

  def destroy_follow_request
    @follow_request = FollowRequest.where(
      recipient_id: params.fetch("path_id"),
      sender_id: current_user.id
    ).first

    recipient = User.where({:id => @follow_request.recipient_id}).at(0)

    if @follow_request
      @follow_request.destroy
      if User.where({ :id => @follow_request.recipient_id }).at(0).private == true
        redirect_to("/", { :alert => "You're not authorized for that." })
      else
        redirect_to("/users/#{recipient.username}", { :notice => "Follow request deleted." })
      end
    else
      redirect_to("/", { :alert => "Unable to delete follow request." })
    end
  end

  def update_follow_request
    @follow_request = FollowRequest.where(
      recipient_id: current_user.id,
      sender_id: params.fetch("path_id")
    ).first

    @follow_request.status = params.fetch("query_status")

    if @follow_request.valid?
      @follow_request.save
      redirect_to("/users/#{current_user.username}", { :notice => "Follow request updated." })
    else
      redirect_to("/users/#{current_user.username}", { :alert => "Unable to update follow request." })
    end

  end 

  def feed
    @the_user_name = params.fetch("username")
    @the_user = User.where({ :username => @the_user_name }).at(0)

    @user_leaders = User.where({ :id => @the_user.id }).at(0).leaders
    @user_following_photos = Photo.where({ :owner_id => @user_leaders.pluck(:recipient_id) })

    render({ :template => "users/feed" })
  end

end
