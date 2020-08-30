class AddTokenCredsToUserForOAuth < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :provider, :string, null: true
  	add_column :users, :uid, :string, null: true
  	add_column :users, :nick_name, :string, null: true
  	add_column :users, :token, :string, null: true
  	add_column :users, :secret, :string, null: true
  end
end
