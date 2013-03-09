namespace :db do

  desc "load return codes data from csv"
  task :load_ret_codes_data, [:csv_file] => :environment do |t , args|
    puts "input file is #{args.csv_file}"

    if  args.csv_file.size == 0
      puts "missing input file name"
      exit
    end
    counter = 0
    FasterCSV.foreach(args[:csv_file],:col_sep => "|", :headers => true  ) do |row|
      counter += 1
      printf "%s", "\nrow count: #{counter}: "
      # load hash with record fields
      row_hash = {}
      row.each do |key, value|
        row_hash[key.strip] = value.nil? ? value : value.strip
      end
      
      # lookup process
      printf "%s", "looking up pdr #{row_hash['pdrtype']}. #{row_hash['pdrstring1']}. #{row_hash['pdrstring2']}"
      pdr_list = Pdr.find(:all,
        :conditions => "pdrstring1 = '#{row_hash['pdrstring1']}' and pdrstring2 =  '#{row_hash['pdrstring2']}' and mvno_procs.pdrtype= #{row_hash['pdrtype']}",
        :joins => :mvno_proc)

      if pdr_list.size == 0
        printf "%s", " No pdr found"
      else
        pdr= pdr_list[0]  # get pdr
        ret_code = pdr.ret_codes.build     # tie new ret_code to pdr 
        # initialize ret_code
        #puts "setting ret_code fields"
        row_hash.sort.each do |key, value|
          func = key.strip + "="
          if ret_code.respond_to? func
            ret_code.send func, value
          #  printf "%s", "#{key}, "
          else
          #  printf "%s",  " #{key} (skipped), "
          end
        end

          if ret_code.save
            printf "%s" , ": ret_code #{ret_code.code} created."
          else
            printf "%s", "  ---- error saving ret_code!"
            ret_code.errors.each{|e| p e}
          end
      end

    end
  end
end
