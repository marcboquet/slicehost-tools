module Resources
  class Zone < Base
    
    def records(reload = false)
      @records = nil if reload
      @records ||= Record.find(:all, :params => { :zone_id => self.id })
    end
        
    class << self
      def find_by_origin(origin)
        find(:first, :params => { :origin => "#{origin}." })
      end
    end                                                                
  end
  
  class Record < Base
  end
end