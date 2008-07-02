module Resources
  class Zone < Base
    
    def records(reload = false)
      @records = nil if reload
      @records ||= Record.find(:all)
      @records.reject! { |r| r.zone_id != self.id }
    end
        
    class << self
      def find_by_origin(origin)
        find(:all).reject { |z| z.origin != "#{origin}." }[0]
      end
    end
    
    def new_zone_and_records_for(domain, ip)
    end
  end
  
  class Record < Base
  end
end