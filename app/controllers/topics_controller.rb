class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :topic_find, except: [:new,:create,:index]
  def index
    @topics = Topic.all
  end
  
  def topic_find
    @topic = Topic.find(params[:id])
  end
    

  def show
    @bookmarks = @topic.bookmarks
  end
  
  def destroy
    if @topic.destroy
      flash[:notice]= "Tpoic was deleted"
      redirect_to topics_path
    else
      flash[:error] = "There was an error please try again"
      redirect_to @topic
    end
  end

  def new
    @topic = Topic.new
  end
  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:notice]= "Your Topic is Created"
      redirect_to @topic
    else
      flash[:error] = "There was an error please try again"
      render :new
    end
  end
  
   def edit
   end
  
  def update
    if @topic.update_attributes(topic_params)
      redirect_to @topic
      flash[:notice] = "Topic was updated"
    else
      flash[:error] = "There was an error updating your topic. Please try again"
      render :edit
    end
  end
  
  private
  
  def topic_params
    params.require(:topic).permit(:title, :user_id)
  end

 
end
