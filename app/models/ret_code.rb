class RetCode < ActiveRecord::Base
  belongs_to :pdr
  attr_accessible :cm_description, :code, :comment, :crm_fields, :description
    
  def self.get_ret_codes_options
   # returns as list of options (array of 2-uples) all error codes defined in the db
   return RetCode.select(:code).uniq.order(:code).map {|rc| [rc.code,rc.code]}
  end
end
