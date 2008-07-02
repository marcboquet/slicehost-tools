module Resources
  class Slice < Base 
    class << self
      def find_by_name(name)                           
        find(:first, :params => { :name => name })
      end
    end
  end
  
  class Flavor < Base
    def to_s; self.name; 
    end
  end
  
  class Image < Base
    def to_s; self.name; 
    end
  end
end