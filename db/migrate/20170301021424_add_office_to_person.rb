class AddOfficeToPerson < ActiveRecord::Migration[5.0]
  def change
    add_reference :people, :office, foreign_key: true
  end
end
