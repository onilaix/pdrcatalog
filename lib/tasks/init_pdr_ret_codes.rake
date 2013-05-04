namespace :db do

  desc "init ret_codes for pdrs"
  task :init_ret_codes => :environment do       
      # lookup process
      printf "%s", "looking up all PDRs"
      pdr_list = Pdr.find(:all)

      if pdr_list.size == 0
        printf "%s", " No pdr found"
      else
        pdr_list.each do |pdr| 
        
        # patch to handle unset "code" in input file
          pdr.pdrstring7 = pdr.get_ret_codes_list
          pdr.save 
          printf "%s" , "(pdr updated)"
        end
      end
  end # end task block
end  # end rake block
