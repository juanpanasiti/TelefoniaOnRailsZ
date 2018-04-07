class BillingsController < ApplicationController
  def index
    @bill_items = BillItem.all
    @bill_headers = BillHeader.all
  end
  def process_bill_csv
    full_csv = Billing.get_full_table(params[:archivo].path)
    @full_csv = Array.new(full_csv)
    final_table = Billing.get_bill_table(full_csv[1])
    @uncharged_items = Billing.get_uncharged_items(full_csv[1])
    @new_items = Billing.get_uncharged_items(full_csv[1])
    @headers = final_table.shift
    @body_table = final_table
    @test = final_table
    #@numbers = Bill.get_number_list(full_csv[1])
  end
  def charge_items
    charged = Billing.charge_new_items(params[:uncharged_items], params[:no_items_count])
    respond_to do |format|
      if charged
        format.html { redirect_to billings_path, notice: 'Nuevos items agregados, debe terminar la configuración.' }
      else
        format.html { redirect_to billings_path, alert: 'Se produjeron errores en la carga de nuevos items.' }
      end
    end
  end
end
