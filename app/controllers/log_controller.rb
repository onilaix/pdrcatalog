class LogController < ApplicationController
  unloadable


  def index
    @pdr_log_list = PdrLog.order("pdrtype, pdrstring1, pdrstring2, created_at")
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

private

  def set_pdr_list(filter)
    if filter == "all"
     @pdr_log_list = PdrLog.order("pdrtype, pdrstring1, pdrstring2, created_at")
    else
      @pdr_log_list = PdrLog.joins("INNER JOIN mvno_procs on mvno_procs.pdrtype = pdr_logs.pdrtype").where("mvno_procs.id = ? ", filter).order("pdrstring1 ASC, pdrstring2 ASC")
    end
  end

end
