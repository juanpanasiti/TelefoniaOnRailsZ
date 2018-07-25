class DocumentsController < ApplicationController
  def new
    @document = Document.new
  end
  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.valid?
        format.html { redirect_to documents_show_data_path(params: @document), notice: 'Documento preparado' }
      else
        format.html { render :new }
      end
    end
  end
  def show_data
    @document = (params[:document])
    #codeshow_data
  end

  protected
  def document_params
    params.require(:document).permit(:giving_number, :name, :lastname, :dni, :office, :aclaration, :device_model, :device_imei, :line, :device_state, :accesories, :configured_by, :date, :dr_condition, :dr_model, :dr_imei, :dr_state, :dr_date, :dr_aclaration, :dr_accesories_returned, :previous_devices)
  end
end
