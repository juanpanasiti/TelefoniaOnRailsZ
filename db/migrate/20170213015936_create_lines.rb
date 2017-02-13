class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
      t.references :person, foreign_key: true
      t.string :number
      t.string :has_inet
      t.string :state
      t.string :type_sim
      t.boolean :has_sms_pack
      t.timestamp :check_date
      t.text :notes
      t.string :bill_account
      t.string :vpn_link
      t.integer :limit_offnet

      t.timestamps
    end
  end
end
