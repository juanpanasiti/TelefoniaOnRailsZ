class BillItem < ApplicationRecord
  belongs_to :bill_header, optional: true
  validates_presence_of :concept_id, :concept_description
  validates_uniqueness_of :concept_id

  ######## CLASS METHODS
  def self.get_header_options
    headers = []
    headers_options = (BillHeader.field_amount + BillHeader.field_sum_end + BillHeader.field_ignore)
    headers_options.each do |h|
      headers << ["#{h.name} (#{h.short_name} - #{h.order})", h.id]
    end
    return headers
  end

  def self.get_quantity_columns_options
    headers = [['No corresponde','']]
    BillHeader.field_quantity.each do |h|
      headers << ["#{h.name} (#{h.short_name} - #{h.order})", h.id]
    end
    return headers
  end

  def self.charge_new_items new_items
    success = true
    new_items.each do |item|
      if BillItem.create(concept_id: item[0], concept_description: item[1])
        success = success && true
      else
        success = success && false
      end
    end
    return success
  end
  def self.get_uncharged_items(full_csv)
    #Generar y devolver arreglo con las columnas
    uncharged_items = []
    items = self.get_items_list full_csv
    items.each do |item|
      unless BillItem.find_by(concept_id: item[0])
        uncharged_items << item
      end
    end
    return uncharged_items
  end

  def self.ignore_item?(item_id)
    # Devuelve true o false según haya que ignorar o no este item
    header = BillItem.find_by_concept_id(item_id).bill_header
    headers_ignored = BillHeader.field_ignore + BillHeader.field_sum_end
    if headers_ignored.include?(header)
      return true
    else
      return false
    end
  end

  private
######################## METODOS DE AUXILIARES
  def self.get_items_list full_csv
    items = []
    full_csv.each do |row|
      unless row[1].to_s.include?(' ')
        items << [row[1],row[2]]
      end
    end
    return items.uniq
  end #END_get_items_list
end
