%w( rubygems thor activeresource fileutils ).each do |dep|
  begin
    require dep
  rescue LoadError
    abort "#{dep} is required for the slicehost-tools suite to run."
  end
end

# add the current directory to the search path...
$: << File.expand_path( File.dirname(__FILE__) )
                                                 
require 'slicehost-tools/extlib'
require 'slicehost-tools'
