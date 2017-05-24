class CreateCells < ActiveRecord::Migration[5.0]
  def change
    create_table :cells do |t|
      t.references :internal, foreign_key: true
      t.references :row, foreign_key: true
      t.string :primary_color
      t.string :secondary_color
      t.string :state
      t.integer :position

      t.timestamps
    end
  end
end
