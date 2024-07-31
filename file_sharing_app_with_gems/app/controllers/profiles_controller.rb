class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def update
    if @user.update(user_params)
      redirect_to pages_dashboard_path, notice: 'Profile updated successfully'
    else
      flash.now[:alert] = 'Failed to update profile'
      render :show
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :name, :email)
  end
end
