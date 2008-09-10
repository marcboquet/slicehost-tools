
if File.exists? File.join(ENV['HOME'], ".slicehost-tools")
  load File.join(ENV['HOME'], ".slicehost-tools")
else            
  require File.dirname(File.join(__FILE__, "tools"))
  Tools::Default.start(['apikey'])
  exit
end
  
class Resource < ActiveResource::Base
  self.site = "http://#{SlicehostSecretKey}@api.slicehost.com" if defined?(SlicehostSecretKey)
end
