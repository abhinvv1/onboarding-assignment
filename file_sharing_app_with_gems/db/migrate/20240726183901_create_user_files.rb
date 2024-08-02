class CreateUserFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :user_files do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :public

      t.timestamps
    end
  end
end
