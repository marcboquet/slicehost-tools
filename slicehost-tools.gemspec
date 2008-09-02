Gem::Specification.new do |s|
  s.name = %q{slicehost-tools}
  s.version = "0.0.5"
 
  s.specification_version = 2 if s.respond_to? :specification_version=
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cameron Cox", "Bobby Uhlenbrock"]
  s.date = %q{2008-09-02}
  s.summary = %q{tools utilizing the slicehost api}
  s.email = %q{cameroncox@gmail.com}
  s.executables = ["slicehost-dns", "slicehost-slice"]
  s.extra_rdoc_files = ["README.markdown", "LICENSE"]
  s.files = ["bin", "bin/slicehost-dns", "bin/slicehost-slice", "lib/", "lib/slicehost-tools", "lib/slicehost-tools/resources", "lib/slicehost-tools/resources/dns.rb", "lib/slicehost-tools/resources/slice.rb", "lib/slicehost-tools/resources.rb", "lib/slicehost-tools/tools", "lib/slicehost-tools/tools/dns.rb", "lib/slicehost-tools/tools/slice.rb", "lib/slicehost-tools/tools.rb", "lib/slicehost-tools.rb", "LICENSE", "Rakefile", "README.markdown", "slicehost-tools.gemspec"]
  # s.has_rdoc = false
  s.homepage = %q{http://github.com/uhlenbrock/slicehost-tools/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.1.1}
  s.add_dependency("wycats-thor", ">= 0.9.2")      
end