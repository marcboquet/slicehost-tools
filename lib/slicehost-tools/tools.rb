module Tools
  
  class Default < Thor
    
    desc "apikey [APIKEY]",
         "set your Slicehost API Key and save it to ~/.slicehost-tools"
    def apikey(apikey = nil)
      @write_file = false
      unless File.exists? File.join(ENV['HOME'], '.slicehost-tools')
        @write_file = true
      else
        # it does exist, ask.
        print "This will replace the stored key, are you sure? [y/N] "
        case STDIN.gets.chomp
        when /y/i
          @write_file = true      
        end
      end
      
      # ask for api key if none is given
      if apikey.nil? && @write_file
        puts "Please enter your API key since you did not provide one: "
        apikey = STDIN.gets.chomp
      end
      
      # write the api key to file
      if @write_file
        File.open( File.join(ENV['HOME'], '.slicehost-tools'), File::RDWR|File::TRUNC|File::CREAT, 0664 ) do |f|
          f.puts "SlicehostSecretKey = '#{apikey}'"
          f.close
        end
      end
    end
  end
end
