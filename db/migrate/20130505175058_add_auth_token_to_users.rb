class AddAuthTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authToken, :string
  end
end
