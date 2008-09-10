class Zone < Resource
  
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

class Record < Resource
  def self.to_zone_rr(options = {})
    "%-20s %-10s IN %-10s %s" % [options[:name], options[:ttl], options[:type], options[:data]]
  end
end  
