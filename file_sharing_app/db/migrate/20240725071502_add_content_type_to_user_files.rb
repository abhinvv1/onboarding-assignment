class AddContentTypeToUserFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_files, :content_type, :string
  end
end
