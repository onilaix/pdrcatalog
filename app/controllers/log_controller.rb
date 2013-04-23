class LogController < ApplicationController
  unloadable


  def index
    @pdr_log_list = PdrLog.order("pdrtype, pdrstring1, pdrstring2, created_at")
  end
end
