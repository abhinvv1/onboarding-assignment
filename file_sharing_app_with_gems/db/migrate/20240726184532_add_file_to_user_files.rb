class AddFileToUserFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_files, :file, :string
  end
end
