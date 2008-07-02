
if File.exists? ENV['HOME'] / :".slicehost-tools"                                        
  load ENV['HOME'] / :".slicehost-tools" 
else            
  require :"slicehost-tools" / :tools              
  Tools::Default.start(['apikey'])
  exit
end

module Resources  
  class Base < ActiveResource::Base
    self.site = "http://#{SlicehostSecretKey}@api.slicehost.com" if defined?(SlicehostSecretKey)
  end
end