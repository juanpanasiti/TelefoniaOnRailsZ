class CreateInternals < ActiveRecord::Migration[5.0]
  def change
    create_table :internals do |t|
      t.string :name
      t.string :prefix
      t.string :number
      t.references :office, foreign_key: true
      t.text :footNote

      t.timestamps
    end
  end
end
