class Billing
  #extend ActiveModel::Naming
  def self.get_full_table(url_csv)
    csv_text = File.read(url_csv, :encoding => 'ISO8859-1').gsub(/\r/, '').gsub('"','')
    csv_text = csv_text.split("\n")
    csv_table = []
    total = 0
    csv_text.each do |row|
      row = row.split(';')
      row.shift(5)
      row.delete_at(4) # Borra monto neto
      row.delete_at(4) # Borra monto impuestos
      total = total + row.last.gsub(',','.').to_f.round(2)
			csv_table << row
    end
    header_table = csv_table.shift #Original_Header
    body_table = csv_table #Body
		return [header_table,body_table,total.round(2)]
  end

  def self.get_bill_table(full_table)
    old_table = self.clean_table(full_table)
    ordered = self.reorder_table(old_table)
    ordered.pop
    headers = self.get_header_array
    new_table = []
    ordered.each do |number|
      line = number[0]
      items = number[1]
      new_row = Array.new(headers.count + 1)
      new_row[0] = line
      items.each do |item|
        p = self.get_position_destiny(item[0].to_s)
        q = self.get_quantity_column(item[0].to_s)
        #new_row[3] = q.class
        if new_row[p].nil?
          new_row[p] = item[3].gsub(',','.').to_f.round(2)
        else
          new_row[p] += item[3].gsub(',','.').to_f.round(2)
        end
        unless q.nil?
          if q == 3
            new_row[q] = 0.0 if new_row[q] == nil
            new_row[q] += item[2].gsub(',','.').to_f.round(2)
          elsif q == 10
            new_row[q] = 0 if new_row[q] == nil
            new_row[q] += item[2].to_i
          end
        end
      end
      new_table << new_row
    end
    new_table.unshift(headers)
    return new_table
    #return ordered
  end #END_get_bill_table

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

  def self.add_items items
    #Agrega los items de la lista y devuelve una dupla de exitos-fracasos
    e = 0 #éxitos
    f = 0 #fracasos
    items.each do |item|
      if BillItem.create(concept_id: item[0], concept_description: item[1])
        e = e + 1
      else
        f = f + 1
      end
    end
    return [e,f]
  end # END_get_uncharged_items

  private
######################## METODOS DE AUXILIARES
  def self.get_items_list full_csv
    items = []
    full_csv.each do |row|
      items << [row[1].to_s,row[2].to_s]
    end
    return items.uniq
  end #END_get_items_list
end
