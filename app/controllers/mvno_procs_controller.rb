class MvnoProcsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize

  def index

    @project = Project.find(params[:project_id])
    @mvno_proc_list = MvnoProc.order("pdrtype")
  end

  def new
    @mvno_proc = MvnoProc.new
  end

  def create
    @mvno_proc = MvnoProc.new(params[:mvno_proc])
    if @mvno_proc.save
      flash[:notice] = "Il processo e' stato creato."
      redirect_to(mvno_procs_url(:project_id =>  session[:project_id]))
    else
      flash[:alert] = "Il processo non e' stato creato"
      render :action => "new"
    end
  end

  def show
    @mvno_proc = MvnoProc.find(params[:id])
  end

  def edit
    @mvno_proc = MvnoProc.find(params[:id])
  end

  def update
    @mvno_proc = MvnoProc.find(params[:id])
    respond_to do |format|
      if @mvno_proc.update_attributes(params[:mvno_proc])
        flash[:notice] = "Aggiornamento eseguito."
        format.html {  redirect_to(mvno_procs_url(:project_id =>  session[:project_id])) }
        format.json  { head :no_content }
      else
      #flash[:alert] = "Errore in aggiornamento."
        format.html { render :action => "edit" }
        format.json  { render :json => @mvno_proc.errors,
        :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @mvno_proc = MvnoProc.find(params[:id])
    pdrtype = @mvno_proc.pdrtype
    name = @mvno_proc.name
    if @mvno_proc.pdrs.find_all.count == 0
      @mvno_proc.destroy
      respond_to do |format|
        flash[:notice] = "Il Processo '#{pdrtype}- #{name}' e' stato rimosso!"
        format.html { redirect_to(mvno_procs_url(:project_id =>  session[:project_id]) ) }
        format.json  { head :no_content }
      end
    else
      flash[:alert] = "Impossible rimuovere il processo: rimuovere prima i PDR collegati"
      render :action => "show"

    end
  end

  private

  def find_project
    session[:project_id] ||= params[:project_id]
    @project = Project.find(session[:project_id])
  end

end
