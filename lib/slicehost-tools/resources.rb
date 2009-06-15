
if File.exists? File.join(ENV['HOME'], ".slicehost-tools")
  load File.join(ENV['HOME'], ".slicehost-tools")
else            
  require File.expand_path(File.dirname(__FILE__) + "/tools")
  Tools::Default.start(['apikey'])
  exit
end
  
class Resource < ActiveResource::Base
  self.site = "https://#{SlicehostSecretKey}@api.slicehost.com" if defined?(SlicehostSecretKey)
end
