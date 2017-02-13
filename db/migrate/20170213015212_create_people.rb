class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :lastname
      t.string :dni
      t.boolean :alert
      t.text :footnote

      t.timestamps
    end
  end
end
