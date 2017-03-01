class CreateDelegations < ActiveRecord::Migration[5.0]
  def change
    create_table :delegations do |t|
      t.string :name
      t.string :address
      t.text :footnote

      t.timestamps
    end
  end
end
