load ENV['HOME'] / :".slicehost-tools"

abort "Please run the set_api_key command to set your apikey" unless defined?(SlicehostSecretKey)

module Resources
  class Base < ActiveResource::Base
    self.site = "http://#{SlicehostSecretKey}@api.slicehost.com"
  end
end