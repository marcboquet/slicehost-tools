class Address < String
end

class Slice < Resource
  class << self
    def find_by_name(name)                           
      find(:first, :params => { :name => name })
    end
  end
  
  def flavor
    Flavor.find(flavor_id)
  end                                       
  
  def image
    Image.find(image_id)
  end
end

class Flavor < Resource
  def to_s; self.name; 
  end
end

class Image < Resource
  def to_s; self.name; 
  end
end 