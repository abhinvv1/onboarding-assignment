class FilesController < ApplicationController
  before_action :authenticate_user!, except: [:show_public, :download]
  before_action :set_user_file, only: [:download, :toggle_public, :destroy]

  def index
    @user_files = current_user.user_files.latest_first.page(params[:page]).per(12)
  end

  def new
    @user_file = current_user.user_files.new
  end

  def create
    @user_file = current_user.user_files.new(user_file_params)
    @user_file.name = @user_file.file.filename if @user_file.name.blank?

    if @user_file.save
      redirect_to files_path, notice: 'File was successfully uploaded.'
    else
      flash.now[:alert] = 'Failed to upload file.'
      render :new
    end
  end

  def download
    @user_file = UserFile.find(params[:id])
    if @user_file.public? || (user_signed_in? && @user_file.user == current_user)
      send_file @user_file.file.path, filename: @user_file.name
    else
      redirect_to root_path, alert: 'You do not have permission to download this file.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'File not found.'
  end

  def toggle_public
    if @user_file.update(public: !@user_file.public)
      redirect_to files_path, notice: 'File sharing status updated successfully.'
    else
      redirect_to files_path, alert: 'Failed to update file sharing status.'
    end
  end

  def destroy
    if @user_file.destroy
      redirect_to files_path, notice: 'File was successfully deleted.'
    else
      redirect_to files_path, alert: 'Failed to delete the file.'
    end
  end

  def show_public
    @user_file = UserFile.find_by(id: params[:id], public: true)
    if @user_file
      render :show_public
    else
      redirect_to root_path, alert: 'File not found or not public.'
    end
  end

  private

  def set_user_file
    @user_file = if user_signed_in?
                   current_user.user_files.find(params[:id])
                 else
                   UserFile.find_by(id: params[:id], public: true)
                 end

    unless @user_file
      redirect_to root_path, alert: 'File not found or you do not have permission to access it.'
    end
  end

  def user_file_params
    params.require(:user_file).permit(:name, :file)
  end
end