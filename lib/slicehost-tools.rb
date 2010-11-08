%w( rubygems thor active_resource fileutils ).each do |dep|
  begin
    require dep
  rescue LoadError
    abort "#{dep} is required for the slicehost-tools suite to run."
  end
end

require File.dirname(__FILE__) + "/slicehost-tools/resources"
require File.dirname(__FILE__) + "/slicehost-tools/tools"
                                          
trap('INT') { exit }