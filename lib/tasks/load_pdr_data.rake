namespace :db do

  desc "load pdr data from csv"
  task :load_pdr_data, [:csv_file] => :environment do |t , args|
    puts "input file is #{args.csv_file}"

    if  args.csv_file.size == 0
      puts "missing input file name"
      exit
    end
    counter = 0
    FasterCSV.foreach(args[:csv_file],:col_sep => "|", :headers => true  ) do |row|
      counter += 1
      puts "row count: #{counter}"
      # load hash with record fields
      row_hash = {}
      row.each do |key, value|
        row_hash[key.strip] = value
      end
      
      # lookup process
      printf "%s",  "searching process #{row_hash['pdrtype']}"
      mvno_proc_list = MvnoProc.where("pdrtype = #{row_hash['pdrtype']}")
      if mvno_proc_list.size == 0
        printf "%s", ": No process found for pdr: #{row_hash['pdrtype']}.#{row_hash['pdrstring1']}.#{row_hash['pdrstring2']}"
      else
        mvno_proc= mvno_proc_list[0]  # get process
        printf "%s", " found process #{mvno_proc.pdrtype}"
        pdr = mvno_proc.pdrs.build     # tie new pdr to process
        # initialize pdr
        #puts "setting pdr fields"
        row_hash.sort.each do |key, value|
          func = key.strip + "="
          if pdr.respond_to? func
            if func.include?("flag") and (! value.nil?) 
            # handle special case
               value = value.downcase == 'x' ? "1" : "0"
            end
            pdr.send func, (value.nil? ? value : value.gsub(/newline/,"\n"))
            #p "#{key}, "
          else
            #p " #{key} (skipped)"
          end
        end

        # save new pdr if min set of fields is set
        if pdr.get_pdr_key != ""
          if pdr.save
            printf "%s",  " pdr #{pdr.get_pdr_key} created."
             Utils.trace_pdr("CREATE", pdr)
          else
            printf "%s",  "  ---- error saving pdr!"
            pdr.errors.each{|e| p e}
          end
        else
          printf "%s" , " pdrkey not set: pdr skipped"
        end
      end

    end
  end
end
