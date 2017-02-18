class CreateSelectorSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :selector_settings do |t|
      t.string :name
      t.string :id_name
      t.string :selector

      t.timestamps
    end
  end
end
