class AddImageDobToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    add_column :users, :DOB, :string
  end
end
