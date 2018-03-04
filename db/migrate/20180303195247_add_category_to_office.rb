class AddCategoryToOffice < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :category, :string
  end
end
