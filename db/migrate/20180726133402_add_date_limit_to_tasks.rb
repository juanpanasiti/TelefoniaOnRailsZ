class AddDateLimitToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :date_limit, :datetime
  end
end
