class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome, #{user.username}"
    else
      @error = "There was an error in your username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logout successful"
  end
end
