
class Utils
	def self.trace_pdr(action,pdr)
		pdr_log = PdrLog.new
		pdr_log.log(action, get_username, pdr)
		pdr_log.save
	end
	
	 def self.get_username
    return User.current.name
  end 

end
