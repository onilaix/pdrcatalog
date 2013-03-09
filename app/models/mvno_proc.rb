class MvnoProc < ActiveRecord::Base
  validates :pdrtype, :presence => true, :numericality => { :greater_than => -1 }, :uniqueness => true
  validates :name, :presence => true
  attr_accessible :name, :pdrtype
  has_many :pdrs
  
  
  def option_text
    return "%02d" % pdrtype.to_s + " - " + name
  end
end
