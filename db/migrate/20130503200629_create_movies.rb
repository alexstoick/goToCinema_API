class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :regizor
      t.string :titluEn
      t.string :titluRo
      t.string :gen
      t.string :actori
      t.string :nota

      t.timestamps
    end
  end
end
