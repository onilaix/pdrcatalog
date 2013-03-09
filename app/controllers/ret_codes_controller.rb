class RetCodesController < ApplicationController
  unloadable
  before_filter :find_project, :authorize
  before_filter :find_pdr
  before_filter :find_ret_code, :only => [:show, :edit, :update, :destroy]
  def index
    @ret_code = @pdr.ret_codes.build
  end

  def new
    @ret_code = RetCode.new
  end

  def create

    @ret_code = @pdr.ret_codes.build(params[:ret_code])
    @ret_code.code = params[:ret_code][:code] !='' ? params[:ret_code][:code] :  params[:code_sel]
    if @ret_code.save
      Utils.trace_pdr("NEW RET_CODE", @pdr)
      flash[:notice] = "Nuovo Return Code creato!"
      redirect_to pdr_ret_codes_url(@pdr)
    #   redirect_to [@mvno_proc, @pdr]
    else
      flash[:alert] = "Errore in creazione nuovo Return Code"
      render :action => "new"
    end
  end

  def edit

  end

  def update
    # handle precedence between select and text fields
    form_params = params[:ret_code]
    form_params[:code] = params[:ret_code][:code ]!='' ? params[:ret_code][:code] :  params[:code_sel]
    if @ret_code.update_attributes(form_params)
      Utils.trace_pdr("UPDATE RET_CODE", @pdr)
      flash[:notice] = "Return Code  aggiornato"
      redirect_to( pdr_ret_codes_url(@pdr))
    else
      flash[:alert] = "Errore in aggiornamento Return Code"
      render :action => "edit"
    end
  end

  def destroy
    @ret_code.destroy
    Utils.trace_pdr("DELETE", @pdr)
#    respond_to do |format|
      flash[:notice] = "Codice di ritorno eliminato"
      #redirect_to( pdr_ret_codes_url(@pdr, :project_id =>  session[:project_id]))
      redirect_to( pdr_ret_codes_url(@pdr))
 #   end
  end

private

  def find_project
    session[:project_id] ||= params[:project_id]
    @project = Project.find(session[:project_id])
  end

  def find_pdr
    @pdr = Pdr.find(params[:pdr_id])
  end

  def find_ret_code
    @ret_code = @pdr.ret_codes.find(params[:id])
  end

end
