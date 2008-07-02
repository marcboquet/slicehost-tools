Gem::Specification.new do |s|
  s.name = "slicehost-tools"
  s.version = "0.0.1"
  s.author  = "Cameron Cox"
  s.email   = "cameroncox@gmail.com"
  s.homepage  = "http://github.com/cameroncox/slicehost-tools"
  s.platform  = Gem::Platform::RUBY
  s.summary   = "tools utilizing the slicehost api"
  s.files     = Dir["{bin,lib}/**/*"].to_a
  s.require_path  = "lib"
  s.has_rdoc      = false
  s.add_dependency("activeresource", ">= 2.0.2")
  s.add_dependency("thor", ">= 0.9.2")
end