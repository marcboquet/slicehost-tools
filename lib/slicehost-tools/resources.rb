
if File.exists? ENV['HOME'] + "/.slicehost-tools"                                        
  load ENV['HOME'] + "/.slicehost-tools"
else            
  require File.dirname(__FILE__) + "/tools"              
  Tools::Default.start(['apikey'])
  exit
end
  
class Resource < ActiveResource::Base
  self.site = "http://#{SlicehostSecretKey}@api.slicehost.com" if defined?(SlicehostSecretKey)
end