class AddNumePrenumeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nume, :string
    add_column :users, :prenume, :string
  end
end
