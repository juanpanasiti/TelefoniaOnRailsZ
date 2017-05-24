class CreateSheets < ActiveRecord::Migration[5.0]
  def change
    create_table :sheets do |t|
      t.integer :position
      t.references :node, foreign_key: true

      t.timestamps
    end
  end
end
