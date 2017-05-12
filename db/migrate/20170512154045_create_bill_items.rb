class CreateBillItems < ActiveRecord::Migration[5.0]
  def change
    create_table :bill_items do |t|
      t.belongs_to :bill_header, foreign_key: true
      t.string :concept_id
      t.string :concept_description
      t.integer :quantity_column

      t.timestamps
    end
  end
end
