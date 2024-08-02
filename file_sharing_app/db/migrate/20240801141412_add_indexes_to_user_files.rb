class AddIndexesToUserFiles < ActiveRecord::Migration[7.1]
  def change
    add_index :user_files, [:user_id, :name]
    add_index :user_files, :public_url, unique: true
    add_index :user_files, :upload_date
    add_index :user_files, :public
  end
end
