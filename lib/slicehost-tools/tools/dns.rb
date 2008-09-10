require File.dirname(__FILE__) + "/../resources/dns"

module Tools
  class DNS < Default
    
    map "-L" => :list
    
    desc "add [DOMAIN] [IP]", "add a domain for the given ip"
    def add(domain = nil, ip = nil)
      unless domain
        puts "Please give a domain to add:"
        domain = STDIN.gets.chomp
      end
      
      unless ip
        puts "Please give the IP to use for this domain:"
        ip = STDIN.gets.chomp
      end

      zone = Zone.new( :origin => "#{domain}.", :ttl => 3660, :active => "Y" )
      
      if zone.save     
        Record.new( :record_type => 'NS',    :zone_id => zone.id, :name => "#{domain}.", :data => "ns1.slicehost.net" ).save
        Record.new( :record_type => 'NS',    :zone_id => zone.id, :name => "#{domain}.", :data => "ns2.slicehost.net" ).save
        Record.new( :record_type => 'NS',    :zone_id => zone.id, :name => "#{domain}.", :data => "ns3.slicehost.net" ).save
        Record.new( :record_type => 'A',     :zone_id => zone.id, :name => "#{domain}.", :data => "#{ip}" ).save    
        Record.new( :record_type => 'CNAME', :zone_id => zone.id, :name => "www",        :data => "#{domain}.").save
        Record.new( :record_type => 'CNAME', :zone_id => zone.id, :name => "ftp",        :data => "#{domain}.").save    
        puts "#{domain} added successfully."
      else
        puts "\n#{domain} could not be added."
        puts zone.errors.full_messages.to_yaml
      end
    end
    
    desc "google_apps [DOMAIN] [IP]", "cofigure Google Apps for the given domain (new or existing)"
    def google_apps(domain = nil, ip = nil)
      unless domain
        puts "Please give a domain to configure:"
        domain = STDIN.gets.chomp
      end
      unless zone = Zone.find(:first, :params => { :origin => "#{domain}." })
        add(domain, ip)
        zone = Zone.find(:first, :params => { :origin => "#{domain}." })
      end
      
      Record.new( :record_type => 'CNAME', :zone_id => zone.id, :name => "mail.",      :data => "ghs.google.com." ).save
      Record.new( :record_type => 'MX',    :zone_id => zone.id, :name => "#{domain}.", :data => "ASPMX.L.GOOGLE.COM.",  :aux => "1" ).save
      Record.new( :record_type => 'MX',    :zone_id => zone.id, :name => "#{domain}.", :data => "ALT1.ASPMX.L.GOOGLE.COM.",  :aux => "5" ).save
      Record.new( :record_type => 'MX',    :zone_id => zone.id, :name => "#{domain}.", :data => "ALT2.ASPMX.L.GOOGLE.COM.",  :aux => "5" ).save
      Record.new( :record_type => 'MX',    :zone_id => zone.id, :name => "#{domain}.", :data => "ASPMX2.GOOGLEMAIL.COM.",  :aux => "10" ).save
      Record.new( :record_type => 'MX',    :zone_id => zone.id, :name => "#{domain}.", :data => "ASPMX3.GOOGLEMAIL.COM.",  :aux => "10" ).save
      puts "#{domain} configured for Google Apps."
    end
    
    desc "list", "lists all zones and their associated records"
    def list(domain = nil)           
      list_params   = { :origin => "#{domain}." } unless domain.nil?
      list_params ||= {}
      Zone.find(:all, :params => list_params).each do |zone|
        puts "+ #{zone.origin}"
        zone.records.each do |record|
          puts [' -', "[#{record.record_type}]".ljust(7, ' '), "#{record.name}"].join(' ')
        end
      end 
    end
    
    desc "delete [DOMAIN]", "removes a domain"
    def delete(domain = nil)
      abort "You must give a domain" if domain.nil?
      
      puts "Type the phrase \"I am sure\" to remove this zone"
      @sure = false
      case STDIN.gets.chomp
      when "I am sure"
        @sure = true
      end
      
      if @sure && domain
        Zone.find_by_origin(domain).destroy
        puts "#{domain} is no more."
      else
        puts "aborting"
      end
    end

    # init Thor
    start 
  end
  desc "Add a record to an existing domain"
  def add_a_record(domain,name,ip)
    unless domain
      puts "Please give a domain to configure:"
      domain = STDIN.gets.chomp
    end
    #lookup the zone
    unless zone = Zone.find(:first, :params => { :origin => "#{domain}." })
      error "Zone #{domain} does not exist, use slicetool-dns add #{domain} IP first!"
    end
    unless name
      puts "Please give a name to configure:"
      name = STDIN.gets.chomp
    end
    unless ip
      puts "Please give a IP to map:"
      ip = STDIN.gets.chomp
    end
    Record.new( :record_type => 'A',     :zone_id => zone.id, :name => name, :data => "#{ip}" ).save    
    puts "Added #{name} ==> #{ip} to #{domain}"
  end
  def add_cname_record(domain,name,cname)
    unless domain
      puts "Please give a domain to configure:"
      domain = STDIN.gets.chomp
    end
    #lookup the zone
    unless zone = Zone.find(:first, :params => { :origin => "#{domain}." })
      error "Zone #{domain} does not exist, use slicetool-dns add #{domain} IP first!"
    end
    unless name
      puts "Please give a name to configure:"
      name = STDIN.gets.chomp
    end
    unless cname
      puts "Please give a CNAME to map:"
      cname = STDIN.gets.chomp
    end
    Record.new( :record_type => 'CNAME', :zone_id => zone.id, :name => name, :data => "#{ip}" ).save    
    puts "Added #{name} ==> #{ip} to #{domain}"
  end
end