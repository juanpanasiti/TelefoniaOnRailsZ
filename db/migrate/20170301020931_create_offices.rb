class CreateOffices < ActiveRecord::Migration[5.0]
  def change
    create_table :offices do |t|
      t.string :name
      t.text :footnote
      t.references :delegation, foreign_key: true
      t.integer :parent_id

      t.timestamps
    end
    add_index :offices, :parent_id
  end
end
