class AddPlanToLine < ActiveRecord::Migration[5.1]
  def change
    add_reference :lines, :plan, foreign_key: true
  end
end
