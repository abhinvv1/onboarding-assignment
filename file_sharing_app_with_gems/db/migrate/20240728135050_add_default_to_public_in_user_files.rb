class AddDefaultToPublicInUserFiles < ActiveRecord::Migration[7.1]
  def change
    change_column_default :user_files, :public, false
  end
end
