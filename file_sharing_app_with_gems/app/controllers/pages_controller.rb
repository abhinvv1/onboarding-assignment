class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def home
    redirect_to pages_dashboard_path if user_signed_in?
  end

  def dashboard
    @recent_files = current_user.user_files.order(created_at: :desc).limit(5)
  end
end
