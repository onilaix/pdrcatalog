class DwhController < ApplicationController
  unloadable


   def index
    @pdr_list = Pdr.find(:all,
        :joins => :mvno_proc,
                          :having => "dwh_flag =1",
              :order => "mvno_procs.pdrtype, pdrstring1, pdrstring2" )
  #@pdr_list = Pdr.all
  end

end
