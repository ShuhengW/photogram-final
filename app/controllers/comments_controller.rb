class CommentsController < ApplicationController

  def create
    @comment = Comment.new
    @comment.body = params.fetch("query_body")
    @comment.author_id = current_user.id
    @comment.photo_id = params.fetch("query_photo_id")

    if @comment.valid?
      @comment.save
      redirect_to("/photos/#{@comment.photo_id}", { :notice => "Comment created successfully." })
    else
      redirect_to("/photos/#{@comment.photo_id}", { :alert => "Unable to create comment." })
    end

  end 

end
