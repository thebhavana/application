class AddFieldToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string
    add_column :users, :bio, :text
    add_column :users, :profile_picture, :string
    add_column :users, :admin, :boolean
  end
end
