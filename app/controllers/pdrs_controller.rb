class PdrsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize
  before_filter :find_pdr, :only => [:show, :edit, :update, :destroy]
  def index
    set_pdr_list("all")
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

  def search
    logger.debug "INPUT FILTER IS #{params[:filter]}"
 
    if params[:commit] == "Reset" or params[:filter] == ""
      set_pdr_list("all")
      params[:filter] = nil
    else
      begin
        MvnoProc.find(params[:filter])  # check if input filter exists
        set_pdr_list(params[:filter])
        rescue ActiveRecord::RecordNotFound
        set_pdr_list("all")
        flash[:alert] = "Per applicare un filtro, seleziona un PdrType"
      end
    end
     render :action => "index"
  end

  private

  def find_project
    session[:project_id] ||= params[:project_id]
    @project = Project.find(session[:project_id])
  end

  def find_pdr
    @pdr = Pdr.find(params[:id])
  end

  def set_pdr_list(filter)
    if filter == "all"
      @pdr_list = Pdr.find(:all,
        :joins => :mvno_proc,
        :order => "mvno_procs.pdrtype, pdrstring1, pdrstring2" )
    else
      @pdr_list = Pdr.joins(:mvno_proc).where("mvno_procs.id = #{filter}").order("pdrstring1 ASC, pdrstring2 ASC")
    end
  end

end
