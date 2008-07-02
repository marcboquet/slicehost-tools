module Resources
  class Slice < Base 
    class << self
      def find_by_name(name)                           
        slice_id = find(:all).reject! { |r| r.name != name }.map { |slice| slice.id }
        find(slice_id)
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