class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.string :name
      t.text :description
      t.string :locations

      t.timestamps
    end
  end
end
