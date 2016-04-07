class FriendsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @friend_request = Friend.where(friend_id: current_user.id, status: "Pending")
    @friends = Friend.where('(friend_id = ? OR user_id = ?) AND status = "Approve"',current_user.id, current_user.id)
    @user_id = @friends.pluck(:user_id, :friend_id).flatten
    @users = User.where(id: @user_id).where.not(id: current_user.id)
    @pending_request = User.where(id: current_user.friends.where(status: "Pending").pluck(:friend_id))
  end

  def new
    @friend = Friend.new
  end

  def create
    @email = params[:email]
    if @email.present?
    	@user = User.find_by_email(@email)
      if @user.blank?
        @user = User.new(email: @email, password: 123456789)
    	  @user.save(:validate => false)
        FriendMailer.mail_password_to_friend(@user).deliver_now
    	end  
      @friend_present = Friend.where('(friend_id = ? OR user_id = ?) AND (friend_id = ? OR user_id = ?) ',  @user.id, @user.id, current_user.id, current_user.id ).first
    	if @friend_present.blank?
  	    @friend = current_user.friends.new(friend_id: @user.id, status: "Pending")
  	    if @friend.save
  	  	  redirect_to user_friends_path(current_user.id)
  	  	  flash[:success] = "Request was send"
  	    else
  	  	  redirect_to new_user_friend_path(current_user.id)
  	  	  flash[:error] = "Request was not send"
  	    end
  	  else 
  	    redirect_to user_friends_path(current_user.id)
  	    flash[:error] = "Already send request to this user"
  	  end
    else
      redirect_to new_user_friend_path(current_user.id)
      flash[:error] = "Email can'nt be blank"
    end  
  end	

  def respond
   	@friend = Friend.find(params[:id])
   	@friend.status = params[:status]
   	if @friend.status == "Reject"
   		@friend.destroy
   		render "my_friend"
   	elsif @friend.save
  	 render "my_friend"
  	end 
  end 
end