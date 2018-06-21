class AddFieldsToInternals < ActiveRecord::Migration[5.1]
  def change
    add_column :internals, :kind, :string
    add_column :internals, :aclaration, :string
    add_column :internals, :service_required, :string
  end
end
