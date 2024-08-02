class AddPublicUrlToUserFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_files, :public_url, :string
  end
end
