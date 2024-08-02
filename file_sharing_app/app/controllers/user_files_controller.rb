class UserFilesController < ApplicationController
  before_action :require_login, except: [:show_public, :download_public]
  before_action :set_user_file, only: [:destroy, :download, :toggle_public]

  def index
    @user_files = current_user.user_files.order(upload_date: :desc)
  end

  def upload
    @user_file = UserFile.new
  end

  def new
    @user_file = UserFile.new
  end

  def create
    @user_file = current_user.user_files.new(user_file_params)
    @user_file.name = params[:user_file][:name]
    # if name is not present then set original name as default filename
    if @user_file.name.blank?
      @user_file.name = params[:user_file][:file_data].original_filename
    end
    @user_file.file_data = params[:user_file][:file_data].read
    @user_file.content_type = params[:user_file][:file_data].content_type

    if @user_file.save
      redirect_to user_files_path, notice: 'File was successfully uploaded.'
    else
      flash.now[:alert] = @user_file.errors.full_messages.to_sentence
      render :upload
    end
  end

  def destroy
    @user_file.destroy
    redirect_to user_files_path, notice: 'File was successfully deleted.'
  end

  def download
    send_file_data(@user_file)
  end

  def download_public
    @user_file = UserFile.find_by!(public_url: params[:public_url], public: true)
    send_file_data(@user_file)
  end

  def toggle_public
    @user_file.update(public: !@user_file.public?)
    if @user_file.public?
      @user_file.update(public_url: SecureRandom.uuid)
    else
      @user_file.update(public_url: nil)
    end
    redirect_to user_files_path, notice: 'File sharing status updated.'
  end

  def show_public
    @user_file = UserFile.find_by(public_url: params[:public_url], public: true)

    if @user_file
      render :show_public
    else
      flash[:alert] = "The requested file is not available or no longer public."
      redirect_to root_path
    end
  end

  private

  def set_user_file
      @user_file = current_user.user_files.find(params[:id])
  end

  def user_file_params
    params.require(:user_file).permit(:name, :file_data, :content_type)
  end

  def send_file_data(file)
    send_data file.file_data,
              filename: file.name,
              type: file.content_type,
              disposition: 'attachment'
    end
end
