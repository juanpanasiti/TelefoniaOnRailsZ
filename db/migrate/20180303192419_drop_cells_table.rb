class DropCellsTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :cells
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
