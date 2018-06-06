class RemoveFootnoteFromOffice < ActiveRecord::Migration[5.1]
  def change
    remove_column :offices, :footnote, :text
  end
end
