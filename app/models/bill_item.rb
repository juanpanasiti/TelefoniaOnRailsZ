class BillItem < ApplicationRecord
  belongs_to :bill_header, optional: true

  ######## CLASS METHODS
  def self.get_header_options

  end

  def self.get_quantity_columns_options

  end
end
