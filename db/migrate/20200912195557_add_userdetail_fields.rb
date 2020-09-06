class AddUserdetailFields < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :image, :string, null: true
  	add_column :users, :screen_name, :string, null: true
  	add_column :users, :followers_count, :string, null: true
  	add_column :users, :friends_count, :string, null: true
  	add_column :users, :statuses_count, :string, null: true
  end
end