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

  def self.get_bill_table(full_table) # full_table es el body sin header
    cleaned_table = self.clean_table(full_table) #quitar filas basura
    ordered = self.reorder_table(cleaned_table)
    #ordered.pop #quita ultima fila
    headers = BillHeader.get_header_array #Encabezado de la tabla final, se insertará al principio de la tabla en el ultimo paso del método
    new_table = [] #new_table será el array devuelto por el método
    ordered.shift
    #return ordered
    if true
      ordered.each do |number|
        line = number[0]
        items = number[1]
        new_row = Array.new(headers.count)
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
            if q == 4
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
      new_table.shift
      new_table.unshift(headers) #meto el header al principio del array
      return new_table
      #return ordered
    end
  end #END_get_bill_table

  def self.get_uncharged_items(full_csv)
    #DEBE SER DE BILL
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

  def self.charge_new_items(new_items, counter)
    # DEBE ESTAR EN BILL
    if new_items.count != counter
      n = 0
      fixed_array = []
      while n < new_items.count
        fixed_array << [new_items[n],new_items[n+1]]
        n = n + 2
      end
      new_items = []
      new_items = fixed_array
    end
    success = true
    new_items.each do |item|
      if BillItem.create(concept_id: item[0], concept_description: item[1])
        success = success && true
      else
        success = success && false
      end
    end
    return success
  end # END_charge_new_items
  def self.get_position_destiny(id)
    item = BillItem.find_by(concept_id: id)
    position = item.bill_header.order
    return position
  end

  def self.get_quantity_column(id)
    item = BillItem.find_by(concept_id: id)
    position = item.quantity_column
    return position
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

  def self.clean_table(full_table)
    # Quita las filas que no son de facturación
    old_table = Array.new(full_table).sort
    cleaned_table = []
    old_table.each do |row|
      unless row.first.include?(' ')
        cleaned_table << row
      end
    end
    return cleaned_table
  end

  def self.reorder_table(table)
    #tab = Array.new(table)
    tab = []
    table.each do |r| # duplicar datos, cambia object_id
      nr = []
      r.each do |e|
        nr << e.dup
      end
      tab << nr.dup
    end # fin de cambio de object_id

    # tab es la nueva table
    #ordered_tab = [] # ordered_tab es la tabla ordenada que devolverá este método
    number_array = [] # [[line,[items_array]]] array de duplas [line,[]]
    number_array << [tab[0,0], []] #inicializado con la primer linea
    pos = 0 #posicion en number_array[pos,1]
    tab.each do |row|
      unless number_array[pos][0].to_s == row[0].to_s
        pos = pos + 1
        number_array << [row[0],[]]
      end
      unless BillItem.ignore_item?(row[1])
        row.shift
        number_array[pos][1] << row
      end
    end
    return number_array
  end # END_reorder_table

end # END_BILLING_CLASS
