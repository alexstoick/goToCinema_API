class AddSenderToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sender_id, :integer
  end
end
