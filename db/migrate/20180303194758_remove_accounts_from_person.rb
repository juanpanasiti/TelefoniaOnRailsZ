class RemoveAccountsFromPerson < ActiveRecord::Migration[5.1]
  def change
    remove_column :people, :accounts, :text
  end
end
