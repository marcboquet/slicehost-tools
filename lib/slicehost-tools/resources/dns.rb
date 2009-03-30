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
  def to_zone_rr                 
    options = { :name => name, :ttl => ttl, :type => type, :data => data }
    options[:id] = id unless new_record?
    self.class.to_zone_rr(options)
  end

  def self.to_zone_rr(options = {})
    id = "; ID=#{options[:id]}" if options[:id]
    "%-20s %-10s IN %-10s %-25s %s" % [options[:name], options[:ttl], options[:type], options[:data], id]
  end
end  
