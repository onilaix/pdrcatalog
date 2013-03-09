class Pdr < ActiveRecord::Base
  belongs_to :mvno_proc
  attr_accessible :notes, :mvno_proc_id, :crm_flag, :description, :dwh_flag, :from_system, :pdrstring1, :pdrstring10, :pdrstring11, :pdrstring12, :pdrstring13, :pdrstring14, :pdrstring15, :pdrstring16, :pdrstring17, :pdrstring18, :pdrstring19, :pdrstring2, :pdrstring20, :pdrstring21, :pdrstring22, :pdrstring23, :pdrstring24, :pdrstring25, :pdrstring26, :pdrstring27, :pdrstring28, :pdrstring29, :pdrstring3, :pdrstring30, :pdrstring31, :pdrstring32, :pdrstring33, :pdrstring34, :pdrstring35, :pdrstring36, :pdrstring37, :pdrstring38, :pdrstring39, :pdrstring4, :pdrstring40, :pdrstring5, :pdrstring6, :pdrstring7, :pdrstring8, :pdrstring9, :to_system
  has_many :ret_codes, :order => "code ASC"
  validates :pdrstring2, :uniqueness => {:scope => [:mvno_proc_id, :pdrstring1],  :message => "pdrkey già assegnata" }
  validate :from_to_system_check
  def get_ret_codes_list
    # returns ordered list of return codes, separated by newlines
    ret_codes_list = ''
    self.ret_codes.order("code").each {|rc| ret_codes_list << "\n" << rc.code}
    return ret_codes_list
  end

  def get_pdr_key
    # returns Pdr key concatenating process pdrtype, pdrstring1 and pdrstring2
    return  [ self.mvno_proc.pdrtype.to_s, self.pdrstring1, self.pdrstring2].join(".")
  end

private

  def from_to_system_check
    rc = true
    if (from_system != "" and to_system == "")
      errors.add(:to_system, "can't be blank if from_system is specified")
    rc = false
    end
    if (from_system == "" and to_system != "")
      errors.add(:from_system, "can't be blank if to_system is specified")
    rc = false
    end
    #if (from_system != "" and to_system != "") and (from_system == to_system)
    #  errors.add(:from_system, "and to_system can't be the same")
    #rc = false
    #end
    return rc
  end

end
