require :"slicehost-tools" / :resources / :dns
module Tools
  class DNS < Default
    
    desc "add [DOMAIN] [IP]", "add a domain for the given ip"
    def add(domain = nil, ip = nil)
      unless domain
        puts "Please give a domain to add:"
        domain = STDIN.gets.chomp
      end
      
      unless ip
        puts "Please give the IP to use for this domain"
        ip = STDIN.gets.chomp
      end

      zone = Resources::Zone.new( :origin => "#{domain}.", :ttl => 3660, :active => "Y" )
      zone.save
      
      Resources::Record.new( :record_type => 'NS',    :zone_id => zone.id, :name => "#{domain}.", :data => "ns1.slicehost.net" ).save
      Resources::Record.new( :record_type => 'NS',    :zone_id => zone.id, :name => "#{domain}.", :data => "ns2.slicehost.net" ).save
      Resources::Record.new( :record_type => 'NS',    :zone_id => zone.id, :name => "#{domain}.", :data => "ns3.slicehost.net" ).save
      Resources::Record.new( :record_type => 'A',     :zone_id => zone.id, :name => "#{domain}.", :data => "#{ip}" ).save    
      Resources::Record.new( :record_type => 'CNAME', :zone_id => zone.id, :name => "www",        :data => "#{domain}.").save
      Resources::Record.new( :record_type => 'CNAME', :zone_id => zone.id, :name => "ftp",        :data => "#{domain}.").save
      
      puts "#{domain} added successfully."
    end
    
    desc "list", "lists all zones and their associated records"
    def list(domain = nil)
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
        Resources::Zone.find_by_origin(domain).destroy
      else
        puts "aborting"
      end
    end

    # init Thor
    start
    
    
  end
end