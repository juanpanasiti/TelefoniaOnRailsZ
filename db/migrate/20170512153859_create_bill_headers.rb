class CreateBillHeaders < ActiveRecord::Migration[5.0]
  def change
    create_table :bill_headers do |t|
      t.string :name
      t.string :short_name
      t.integer :order
      t.string :type_field
      t.string :type_value

      t.timestamps
    end
  end
end
