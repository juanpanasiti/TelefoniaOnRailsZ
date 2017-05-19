class BillingsController < ApplicationController
  def index
    #code
  end
  def process_bill_csv
    full_csv = Billing.get_full_table(params[:archivo].path)
    @full_csv = Array.new(full_csv)
    #final_table = Billing.get_bill_table(full_csv[1])
    @uncharged_items = Billing.get_uncharged_items(full_csv[1])
    @headers = [] # final_table.shift
    @body_table = [] # final_table
    #@numbers = Bill.get_number_list(full_csv[1])
  end
end
