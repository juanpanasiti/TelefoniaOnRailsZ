class CreateDeviceModels < ActiveRecord::Migration[5.0]
  def change
    create_table :device_models do |t|
      t.string :mark
      t.string :device_name
      t.string :device_code
      t.string :accessories
      t.text :details
      t.string :type_sim
      t.string :specs_link
      t.boolean :slot_sd
      t.string :category
      t.string :band
      t.string :os

      t.timestamps
    end
  end
end
