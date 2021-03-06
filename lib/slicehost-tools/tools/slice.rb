require File.dirname(__FILE__) + "/../resources/slice"

module Tools
  class Slice < Default
     
    map "-L" => :list
    
    desc "add [SLICE NAME]", "add a new slice"
    method_options :force => :boolean
    def add(slice_name)
      images  = ::Image.find(:all)
      flavors = ::Flavor.find(:all)
            
      puts "Available Images: "
      image_id = select_image_from(images)
      
      puts "Available Flavors: "
      flavor_id = select_flavor_from(flavors)
      
      @add = false
      # confirm  you want to do this, it does cost money
      unless options[:force]     
        print "Are you sure you want do this? [y/N]: "
        case STDIN.gets.chomp
        when /y/i
          @add = true
        end
      end

      if @add
        slice = ::Slice.new(:name => slice_name, :flavor_id => flavor_id, :image_id => image_id)
        slice.save
      end
      
    end
    
    desc "delete [SLICE]", "delete a slice" 
    def delete(slice_name = nil)                            
      slice_name = select_slice.name if slice_name.nil?
        
      @abort = true
      slice = ::Slice.find_by_name(slice_name)
      puts "Please type 'I understand this is not undoable' to proceed: "
      case STDIN.gets.chomp
      when "I understand this is not undoable"
        @abort = false
      end
      
      unless @abort
        puts "You have 5 seconds to change your mind (CTRL+C)"
        sleep 5
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
      ::Slice.find(:all).each do |slice|
        puts "+ #{slice.name} (#{slice.addresses})"
      end
    end
                                                    
    desc "status [SLICENAME]", "get information about a slice"
    def status(slice_name = nil)
      slice_name = select_slice.name if slice_name.nil?
      
      slice = ::Slice.find_by_name(slice_name)
      puts "Name:               #{slice.name} (#{slice.addresses})"
      puts "Flavor:             #{slice.flavor} (#{slice.image})"
      puts "Status:             #{slice.status}"
      puts "Bandwidth (in/out): #{slice.bw_in}/#{slice.bw_out}"
    end

    desc "hard_reboot [SLICE]", "perform a hard reboot"
    def hard_reboot(slice_name = nil)
      slice_name = select_slice.name if slice_name.nil?
      
      puts "(hard) rebooting #{slice_name}"                      
      reboot(:hard_reboot, slice_name)
    end              

    desc "soft_reboot [SLICE]", "perform a soft reboot"
    def soft_reboot(slice_name = nil)                       
      slice_name = select_slice.name if slice_name.nil?
      
      puts "(soft) rebooting #{slice_name}"
      reboot(:reboot, slice_name)
    end


    protected
       
      def select_slice
        slices = ::Slice.find(:all)
        slices.each_index { |i| puts "[#{i}] #{slices[i].name}" }
        print "Select a Slice by #: "
        input = STDIN.gets.chomp.to_i
        slices[input]
      end

      def select_image_from(images)
        images.each_index { |i| puts "[#{i}] #{images[i].name}" } 
        print "Select an Image by #: "
        input = STDIN.gets.chomp.to_i
        images[input].id
      end

      def select_flavor_from(flavors)
        flavors.each_index { |i| puts "[#{i}] #{flavors[i].name} (#{flavors[i].ram}mb) ($#{flavors[i].price}/month)" }
        print "Select an Image by #: "
        input = STDIN.gets.chomp.to_i
        flavors[input].id
      end

      def reboot(type, slice_name)
        slice = ::Slice.find_by_name(slice_name)
        slice.put(type)
      end
    
    public
        
    # init thor
    start                                             
  end
end
