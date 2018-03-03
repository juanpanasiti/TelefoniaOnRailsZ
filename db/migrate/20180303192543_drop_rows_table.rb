class DropRowsTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :rows
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
