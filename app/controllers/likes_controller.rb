class LikesController < ApplicationController
  
  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = @bookmark.topic
    @like = current_user.likes.new(bookmark_id: @bookmark.id)
    if @like.save
      flash[:notice] = "Liked"
      redirect_to @topic
    else
      flash[:error] = "Try again"
      redirect_to @topic
    end
  end
  
  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    @topic = @bookmark.topic
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:notice] = "Unliked"
      redirect_to @topic
    else
      flash[:error] = "Try again"
      redirect_to @topic
    end
  end
    
end
