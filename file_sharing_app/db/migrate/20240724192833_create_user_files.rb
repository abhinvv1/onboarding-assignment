class CreateUserFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_files do |t|
      t.string :name
      t.binary :file_data
      t.date :upload_date
      t.boolean :public
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
