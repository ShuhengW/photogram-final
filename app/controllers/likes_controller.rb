class LikesController< ApplicationController

  def create
    @like = Like.new
    @like.fan_id = current_user.id
    @like.photo_id = params.fetch("query_photo_id")

    if @like.valid?
      @like.save
      redirect_to("/photos/#{@like.photo_id}", { :notice => "Like created successfully." })
    else
      redirect_to("/photos/#{@like.photo_id}", { :alert => "Unable to create like." })
    end

  end 

  def destroy
    @like = Like.where({ :photo_id => params.fetch("path_id"), :fan_id => current_user.id }).at(0)

    if @like
      @like.destroy
      redirect_to("/photos/#{@like.photo_id}", { :notice => "Like deleted successfully." })
    else
      redirect_to("/photos/#{@like.photo_id}", { :alert => "Unable to delete like." })
    end
  end
end 
