class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      redirect_to dashboard_path
    else
      flash[:notice] = "Username already taken"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :last_name, :first_name, :address)
  end
end
