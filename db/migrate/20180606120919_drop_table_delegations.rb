class DropTableDelegations < ActiveRecord::Migration[5.1]
  def change
    drop_table :delegations
  end
end
