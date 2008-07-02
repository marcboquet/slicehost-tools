require :"slicehost-tools" / :resources / :dns
module Tools
  class DNS < Default
    
    desc "add [DOMAIN]", "add a domain"
    def add(domain = nil)
      
    end
    
    desc "list", "lists all zones and their associated records"
    def list
      Resources::Zone.find(:all).each do |zone|
        puts "+ #{zone.origin}"
        zone.records.each do |record|
          puts [' -', "[#{record.record_type}]".ljust(7, ' '), "#{record.name}"].join(' ')
        end
      end 
    end
    
    desc "delete [DOMAIN]", "removes a domain"
    def delete(domain = nil)
      abort "You must give a domain" if domain.nil?
      
      puts "Type the phrase \"Bob's your uncle\" to remove this zone"
      @sure = false
      case STDIN.gets.chomp
      when "Bob's your uncle"
        @sure = true
      end
      
      if @sure && domain
        Resources::Zone.find_by_origin(domain).delete
      else
        puts "aborting"
      end
    end

    # init Thor
    start

  end
end