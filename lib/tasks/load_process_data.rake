namespace :db do

  desc "load process data from csv"
  task :load_process_data, [:csv_file] => :environment do |t , args|
    puts "input file is #{args.csv_file}"

    if  args.csv_file.size == 0
      puts "missing input file name"
      exit
    end
    counter = 0
    FasterCSV.foreach(args[:csv_file],:col_sep => ",", :headers => true) do |row|
      counter += 1
      puts "row count: #{counter}"
      project = MvnoProc.new
      row.each do |key, value|
        puts "key=#{key}, value=#{value} "
        func = key +"="
        if project.respond_to? func
          if func.include? "pdrtype"
          project.send func, value.to_i
          else
          project.send func, value
          end
          puts "method #{func} called"
        else
          puts "project not responding to  #{func} called"
        end
      end
      if project.save
        p "  ---- project saved!"
      else
        p "  ---- error saving project!"
        project.errors.each{|e| p e}
      end
    end
  end
end
