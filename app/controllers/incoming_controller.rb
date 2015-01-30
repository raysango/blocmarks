class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    puts "INCOMING PARAMS HERE: #{params}"
    @user = User.where(email: "#{params[:sender]}").last
    @topic = Topic.where(title: "#{params[:subject]}").last
    @url = params["body-plain"].gsub!(/\s/,'')
# check for syntax http://www.tutorialspoint.com/ruby/ruby_regular_expressions.htm

if @user != nil && @topic != nil
    @bookmark = @topic.bookmarks.new(url: @url)
   @bookmark.save!
elsif @user != nil && @topic == nil
  @t = Topic.create(title: "#{params[:subject]}", user_id: @user.id)
  @bookmark = @t.bookmarks.new(url: @url)
   @bookmark.save!
elsif @user == nil && @topic != nil
@u = User.new(email:"#{params[:sender]}", password: "password", password_confirmation: "password")
       @u.skip_confirmation!
       @u.save!
 @bookmark = @topic.bookmarks.new(url: @url)
   @bookmark.save!
else
@u = User.new(email:"#{params[:sender]}", password: "password", password_confirmation: "password")
       @u.skip_confirmation!
       @u.save!
 @t = Topic.create(title: "#{params[:subject]}", user_id: @u.id)
@bookmark = @t.bookmarks.new(url: @url)
   @bookmark.save!

end
 
    head 200
  end
end