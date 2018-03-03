class DropSelectorSettingTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :selector_settings
  end
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
