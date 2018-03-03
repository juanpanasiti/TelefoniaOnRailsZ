class DropSheetsTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :sheets
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
