class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.belongs_to :device_model, foreign_key: true
      t.string :imei
      t.references :line, foreign_key: true
      t.boolean :is_personal
      t.string :state
      t.string :failure
      t.timestamp :check_date
      t.text :details

      t.timestamps
    end
  end
end
