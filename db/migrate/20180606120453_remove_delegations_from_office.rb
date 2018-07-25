class RemoveDelegationsFromOffice < ActiveRecord::Migration[5.1]
  def change
    #remove_reference :offices, :delegation, foreign_key: true
  end
end
