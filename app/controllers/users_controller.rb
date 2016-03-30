class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :check_user, only: [:new,:sign_in]
	
  def index
  end		

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end	

  def edit
    @user = current_user
  end
    
  def create
    @user=User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      session[:current_user] = @user
      flash[:success] = "Registration done."
      redirect_to user_path(@user.id) 
    else
      flash[:error] = @user.errors.full_messages.join('.').html_safe
      redirect_to new_user_path
    end 
  end 

  def update
    if current_user.update(user_params)
        redirect_to user_path(current_user),notice: 'User was successfully updated.'
      else
         flash[:error] = @current_user.errors.full_messages.join('<br>').html_safe
         redirect_to edit_user_path
      end
    end

  def sign_in
    @user = User.new 
  end

  def authentication
    @user= User.where(email: params[:user][:email], password: params[:user][:password]) 
    if @user.blank? 
      flash[:error] = "Invalid login or password"
      redirect_to sign_in_users_path
    else
      session[:current_user] = @user.first
      flash[:success] = "Login successfully."
      redirect_to users_path 
    end
  end 	

  def logout
    session[:current_user]=nil
    flash[:success] = "Logged out"
    redirect_to sign_in_users_path
  end
  

  def forgot_password
  end

  def send_password
    @user=User.find_by_email(params[:user][:email])
    if @user.blank? 
      redirect_to forgot_password_users_path, alert: "Please enter email"
    else  
      UserMailer.send_password(@user).deliver_now
    end  
  end 

  private

  def check_user
    if current_user.present?
      redirect_to users_path
    end
  end 

  def user_params
    params.require(:user).permit(:user_name, :email, :first_name, :last_name, :password, :password_confirmation, :team, :password_digest)
  end
end