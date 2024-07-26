class AddSizeToUserFiles < ActiveRecord::Migration[7.1]
  def change
    add_column :user_files, :size, :string
  end
end
