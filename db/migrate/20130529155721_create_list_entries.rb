class CreateListEntries < ActiveRecord::Migration
  def change
    create_table :list_entries do |t|
      t.integer :movie_id
      t.integer :list_id

      t.timestamps
    end
  end
end
