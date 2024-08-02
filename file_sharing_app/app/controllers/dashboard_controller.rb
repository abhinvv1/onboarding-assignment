class DashboardController < ApplicationController
  before_action :require_login

  def index
    @recent_files = current_user.user_files.order(upload_date: :desc).limit(DASHBOARD_RECENT_FILES_LIMIT)
  end
end
