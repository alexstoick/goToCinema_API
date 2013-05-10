class CreateShowtimes < ActiveRecord::Migration
  def change
    create_table :showtimes do |t|
      t.string :place
      t.string :hour
      t.integer :movie_id

      t.timestamps
    end
  end
end
