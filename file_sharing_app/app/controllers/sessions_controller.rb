class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      login(user)
      redirect_to dashboard_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = "Couldn’t find that user! Please try again"
      @username = params[:username]
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out successfully!'
  end
end