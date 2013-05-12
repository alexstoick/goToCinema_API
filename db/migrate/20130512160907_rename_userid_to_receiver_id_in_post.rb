class RenameUseridToReceiverIdInPost < ActiveRecord::Migration
	def change
		rename_column :posts, :user_id, :receiver_id
	end
end
