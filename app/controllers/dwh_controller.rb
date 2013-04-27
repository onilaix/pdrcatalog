class DwhController < ApplicationController
  unloadable
  def index
    @pdr_list = Pdr.find(:all,
        :joins => :mvno_proc,
                          :having => "dwh_flag =1",
              :order => "mvno_procs.pdrtype, pdrstring1, pdrstring2" )
  #@pdr_list = Pdr.all
  end

  def search
    logger.debug "INPUT FILTER FOR CONTROLLER  #{params[:controller]} IS #{params[:filter]}"

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

  def set_pdr_list(filter)
    if filter == "all"
      @pdr_list = Pdr.find(:all,
        :joins => :mvno_proc,
        :having => "dwh_flag =1",
        :order => "mvno_procs.pdrtype, pdrstring1, pdrstring2" )
    else
      @pdr_list = Pdr.joins(:mvno_proc).where("mvno_procs.id = ? AND dwh_flag = 1", filter).order("pdrstring1 ASC, pdrstring2 ASC")
    end
  end

end
