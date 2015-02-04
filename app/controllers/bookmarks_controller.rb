class BookmarksController < ApplicationController
  before_action :book_find, except: [:new, :create]
  
  def book_find
    @bookmark = Bookmark.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @bookmark
  end
  def destroy
    if @bookmark.destroy
      flash[:notice]= "Bookmark deleted"
      redirect_to @topic
    else
      flash[:error]= "Try again later"
      redirect_to @topic
    end
  end
  
  

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new
    authorize @bookmark
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params)
    authorize @bookmark
    if @bookmark.save
      flash[:notice] = "Bookmark saved"
      redirect_to @topic
    else
      flash[:error] = "There was an error please try again"
      render :new
    end
  end
    

  def edit
  end
  
  def update
    if @bookmark.update_attributes(bookmark_params)
      flash[:notice]= "Bookmark Updated"
      redirect_to @topic
    else
      flash[:error]= "Try again later"
      render :edit
    end
  end
  private
  
  def bookmark_params
    params.require(:bookmark).permit(:url, :topic_id_id)
  end
end
