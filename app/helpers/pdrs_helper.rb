module PdrsHelper

   def get_system_options
    # return list of systems to be used in select-options html
    return [
       ["-interno-",""],
      ["AMD", "AMD"],
      ["DS","DS"],
      ["DS-LITE","DS-LITE"],
      ["GW", "GW"],
      ["KEY CLIENT", "KEY CLIENT"],
      ["PORTALE SC","PORTALE SC"],
      ["SMS", "SMS"],
      ["SSB","SSB"],
      ["TSE", "TSE"]
      ]
  end
  
 
end
