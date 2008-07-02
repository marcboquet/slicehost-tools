require :"slicehost-tools" / :resources / :slice
module Tools
  class Slice < Default
    
    desc "add [SLICE NAME]", "add a new slice"
    method_options :force => :boolean
    def add(slice_name, opts)               
      images  = Resources::Image.find(:all)
      flavors = Resources::Flavor.find(:all)
            
      puts "Available Images: "      
      image_id = select_image_from(images)   
      
      puts "Available Flavors: "
      flavor_id = select_flavor_from(flavors)
      
      @add = false
      # confirm  you want to do this, it does cost money
      unless opts[:force]     
        print "Are you sure you wanna do this? [y/N]: "
        case STDIN.gets.chomp
        when /y/i
          @add = true
        end
      end

      if @add
        slice = Resources::Slice.new(:name => slice_name, :flavor_id => flavor_id, :image_id => image_id)
        slice.save
      end
      
    end
    
    desc "delete [SLICE]", "delete a slice" 
    def delete(slice_name = nil)
      abort "please provide a slice name" if slice_name.nil?
        
      @abort = true
      slice = Resources::Slice.find_by_name(slice_name)
      puts "Please type 'I understand this is not undoable' to proceed: "
      case STDIN.gets.chomp
      when "I understand this is not undoable"
        @abort = false
      end
      
      unless @abort
        puts "Say goodnight gracie."
        slice.destroy
        sleep 3
        puts "Goodnight gracie."   
      else
        puts "Your slice has not been nuked. (I hope)"
      end
      
    end
    
    desc "list", "list slices"
    def list
      Resources::Slice.find(:all).each do |slice|
        puts "+ #{slice.name} (#{slice.ip_address})"
      end
    end

    desc "hard_reboot [SLICE]", "perform a hard reboot"
    def hard_reboot(slice_name = nil)
      abort "please provide a slice name" if slice_name.nil?
      
      puts "(hard) rebooting #{slice_name}"                      
      reboot(:hard_reboot, slice_name)
    end              

    desc "soft_reboot [SLICE]", "perform a soft reboot"
    def soft_reboot(slice_name = nil)
      abort "please provice a slice name" if slice_name.nil?
      
      puts "(soft) rebooting #{slice_name}"
      reboot(:reboot, slice_name)
    end


    protected

      def select_image_from(images)
        images.each_index { |i| puts "[#{i}] #{images[i].name}" } 
        print "Select an Image by ID: "
        input = STDIN.gets.chomp.to_i
        images[input].id
      end

      def select_flavor_from(flavors)
        flavors.each_index { |i| puts "[#{i}] #{flavors[i].name} (#{flavors[i].ram}mb) ($#{flavors[i].price}/month)" }
        print "Select an Image by ID: "
        input = STDIN.gets.chomp.to_i
        flavors[input].id
      end

      def reboot(type, slice_name)
        slice = Resources::Slice.find_by_name(slice_name)
        slice.put(type)
      end
    
    public
        
    # init thor
    start                                             
  end
end
