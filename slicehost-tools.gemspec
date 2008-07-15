Gem::Specification.new do |s|
  s.name = %q{slicehost-tools}
  s.version = "0.0.2"
 
  s.specification_version = 2 if s.respond_to? :specification_version=
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cameron Cox"]
  s.date = %q{2008-07-1}
  s.summary = %q{tools utilizing the slicehost api}
  s.email = %q{cameroncox@gmail.com}
  s.executables = ["slicehost-dns", "slicehost-slice"]
  s.extra_rdoc_files = ["README.markdown", "LICENSE"]
  s.files = Dir['**/**'].reject!{ |f| f =~ /pkg/i }
  s.has_rdoc = false
  s.homepage = %q{http://github.com/cameroncox/slicehost-tools/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.1.1}
  s.add_dependency("thor", ">= 0.9.2")      
end
