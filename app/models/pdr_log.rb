class PdrLog < ActiveRecord::Base
  attr_accessible :pdrtype, :name, :action, :username, :crm_flag, :description, :dwh_flag, :from_system, :pdrstring1, :pdrstring10, :pdrstring11, :pdrstring12, :pdrstring13, :pdrstring14, :pdrstring15, :pdrstring16, :pdrstring17, :pdrstring18, :pdrstring19, :pdrstring2, :pdrstring20, :pdrstring21, :pdrstring22, :pdrstring23, :pdrstring24, :pdrstring25, :pdrstring26, :pdrstring27, :pdrstring28, :pdrstring29, :pdrstring3, :pdrstring30, :pdrstring31, :pdrstring32, :pdrstring33, :pdrstring34, :pdrstring35, :pdrstring36, :pdrstring37, :pdrstring38, :pdrstring39, :pdrstring4, :pdrstring40, :pdrstring5, :pdrstring6, :pdrstring7, :pdrstring8, :pdrstring9, :to_system

    def log(action, username, pdr)
      self.action=action
      self.username=username
      if pdr.class.name == 'Pdr' 
          self.crm_flag    = pdr.crm_flag
          self.dwh_flag    = pdr.dwh_flag
          self.pdrtype     = pdr.mvno_proc.pdrtype
          self.name        = pdr.mvno_proc.name
          self.from_system = pdr.from_system
          self.to_system   = pdr.to_system
          self.description = pdr.description
          self.pdrstring1  = pdr.pdrstring1
          self.pdrstring2  = pdr.pdrstring2
          self.pdrstring3  = pdr.pdrstring3
          self.pdrstring4  = pdr.pdrstring4
          self.pdrstring5  = pdr.pdrstring5
          self.pdrstring6  = pdr.pdrstring6
          self.pdrstring7  = pdr.get_ret_codes_list 
          self.pdrstring8  = pdr.pdrstring8
          self.pdrstring9  = pdr.pdrstring9
          self.pdrstring10 = pdr.pdrstring10
          self.pdrstring11 = pdr.pdrstring11
          self.pdrstring12 = pdr.pdrstring12
          self.pdrstring13 = pdr.pdrstring13
          self.pdrstring14 = pdr.pdrstring14
          self.pdrstring15 = pdr.pdrstring15
          self.pdrstring16 = pdr.pdrstring16
          self.pdrstring17 = pdr.pdrstring17
          self.pdrstring18 = pdr.pdrstring18
          self.pdrstring19 = pdr.pdrstring19
          self.pdrstring20 = pdr.pdrstring20
          self.pdrstring21 = pdr.pdrstring21
          self.pdrstring22 = pdr.pdrstring22
          self.pdrstring23 = pdr.pdrstring23
          self.pdrstring24 = pdr.pdrstring24
          self.pdrstring25 = pdr.pdrstring25
          self.pdrstring26 = pdr.pdrstring26
          self.pdrstring27 = pdr.pdrstring27
          self.pdrstring28 = pdr.pdrstring28
          self.pdrstring29 = pdr.pdrstring29
          self.pdrstring30 = pdr.pdrstring30
          self.pdrstring31 = pdr.pdrstring31
          self.pdrstring32 = pdr.pdrstring32
          self.pdrstring33 = pdr.pdrstring33
          self.pdrstring34 = pdr.pdrstring34
          self.pdrstring35 = pdr.pdrstring35
          self.pdrstring36 = pdr.pdrstring36
          self.pdrstring37 = pdr.pdrstring37
          self.pdrstring38 = pdr.pdrstring38
          self.pdrstring39 = pdr.pdrstring39          
          self.pdrstring40 = pdr.pdrstring40
          self.notes       = pdr.notes
      end
    end  
  
    def get_ret_codes_list
      # returns list of return_codes
      return self.pdrstring7
    end

  def get_pdr_key
    # returns Pdr key concatenating process pdrtype, pdrstring1 and pdrstring2
      return  [ self.pdrtype.to_s, self.pdrstring1, self.pdrstring2].join(".")
   end
end
