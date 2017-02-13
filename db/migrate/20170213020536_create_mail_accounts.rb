class CreateMailAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :mail_accounts do |t|
      t.string :email
      t.string :pass
      t.belongs_to :person, foreign_key: true

      t.timestamps
    end
  end
end
