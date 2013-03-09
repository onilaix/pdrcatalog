class PdrsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize
  before_filter :find_pdr, :only => [:show, :edit, :update, :destroy]
  def index
    @pdr_list = Pdr.find(:all,
        :joins => :mvno_proc,
        :order => "mvno_procs.pdrtype, pdrstring1, pdrstring2" )
  end

  def new
    @pdr = Pdr.new
  end

  def create
    @pdr = Pdr.new( params[:pdr])
    @pdr.mvno_proc = MvnoProc.find(params[:pdr][:mvno_proc_id])
    if @pdr.save
      Utils.trace_pdr("CREATE", @pdr)

      flash[:notice] = "PDR creato."
      redirect_to(@pdr)
    #    redirect_to(pdr_url(@pdr, :project_id =>  session[:project_id]))
    else
      flash[:alert] = "Errore in creazione nuovo PDR"
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pdr.update_attributes(params[:pdr])
      Utils.trace_pdr("UPDATE", @pdr)

      flash[:notice] = "PDR aggiornato"
      redirect_to [@pdr]
    else
      flash[:alert] = "Errore in aggiornamento PDR"
      render :action => "edit"
    end
  end

  def destroy
    pdr_info = @pdr.get_pdr_key + " - " + @pdr.description
    if (@pdr.ret_codes.find_all.count == 0)
      Utils.trace_pdr("DELETE", @pdr)

      @pdr.destroy
      respond_to do |format|
        flash[:notice] = "PDR eliminato: " + pdr_info
        format.html { redirect_to(pdrs_path) }
        format.json  { head :no_content }
      end
    else
      flash[:alert] = "Impossible rimuovere il PDR: rimuovere prima tutti i codici di ritorno collegati"
      render :action => "show"
    end
  end

  def log
    @pdr_log_list = PdrLog.order("pdrtype, pdrstring1, pdrstring2, created_at")
  end

  def dwh
    @pdr_list = Pdr.find(:all,
        :joins => :mvno_proc,
                          :having => "dwh_flag =1",
              :order => "mvno_procs.pdrtype, pdrstring1, pdrstring2" )
  #@pdr_list = Pdr.all
  end

private

  def find_project
    session[:project_id] ||= params[:project_id]
    @project = Project.find(session[:project_id])
  end

  def find_pdr
    @pdr = Pdr.find(params[:id])
  end

end
