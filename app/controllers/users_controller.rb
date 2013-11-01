class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Registration Successful!"
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :timezone)
    end
end