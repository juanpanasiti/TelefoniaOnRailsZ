class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :normal_price
      t.string :roaming
      t.integer :onnet_pack
      t.integer :offnet_pack
      t.integer :sms_pack
      t.string :inet_pack
      t.decimal :credit
      t.string :kind
      t.text :details

      t.timestamps
    end
  end
end
