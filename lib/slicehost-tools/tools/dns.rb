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

    desc "tozonefile", "output a zone file for the given domain"
    def tozonefile(domain = nil)           
      abort "You must give a domain" if domain.nil?
      zone = Zone.find_by_origin(domain)

      puts "\$ORIGIN #{zone.origin.sub(/\.$/, '')}"
      puts "\$TTL #{zone.ttl}"
      puts "@ IN SOA ns.slicehost.net. #{ENV['USER']}.#{zone.origin} ("
      puts "#{Time.now.strftime('%Y%m%d%H%M%S')} ; serial number"
      puts "1d         ; time to refresh"
      puts "1d         ; time to retry"
      puts "4w         ; time to expire"
      puts "1h         ; minimum ttl"
      puts ")"

      [1,2,3].each do |i|
        puts Record.to_zone_rr(:name => '@',
                               :type => 'NS',
                               :data => "ns#{i}.slicehost.net")
      end

      sort_order = ['NS', 'MX', 'TXT', 'SRV', 'A', 'PTR', 'AAAA', 'CNAME']
      zone.records.sort {|a,b| sort_order.index(a.record_type) <=> sort_order.index(b.record_type)}.each do |record|
        name = record.name == zone.origin ? '@' : record.name
        ttl = '' if record.ttl == zone.ttl
        aux = ''
        data = record.data
        case record.record_type
          when 'MX'
            data = "#{record.aux} #{data}"
          when 'SRV'
            data = "#{record.aux} #{data}"
          when 'TXT'
            data = "\"#{record.data}\""
        end
        puts Record.to_zone_rr(:name => name,
                               :ttl => ttl,
                               :type => record.record_type,
                               :data => data)
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
end
