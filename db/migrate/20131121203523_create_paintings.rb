class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :image
      t.string :title
      t.string :caption
      t.integer :ordinal

      t.timestamps
    end
  end
end
