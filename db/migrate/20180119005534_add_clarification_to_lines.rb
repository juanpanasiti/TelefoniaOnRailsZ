class AddClarificationToLines < ActiveRecord::Migration[5.1]
  def change
    add_column :lines, :clarification, :string
  end
end
