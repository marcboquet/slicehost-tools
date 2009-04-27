# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{slicehost-tools}
  s.version = "0.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cameron Cox", "Bobby Uhlenbrock", "Corey Martella"]
  s.date = %q{2008-09-10}
  s.email = %q{cameroncox@gmail.com}
  s.executables = ["slicehost-dns", "slicehost-slice"]
  s.extra_rdoc_files = ["README.markdown", "LICENSE"]
  s.files = ["bin", "bin/slicehost-dns", "bin/slicehost-slice", "lib", "lib/slicehost-tools", "lib/slicehost-tools/resources", "lib/slicehost-tools/resources/dns.rb", "lib/slicehost-tools/resources/slice.rb", "lib/slicehost-tools/resources.rb", "lib/slicehost-tools/tools", "lib/slicehost-tools/tools/dns.rb", "lib/slicehost-tools/tools/slice.rb", "lib/slicehost-tools/tools.rb", "lib/slicehost-tools.rb", "LICENSE", "Rakefile", "README.markdown", "slicehost-tools.gemspec"]
  s.homepage = %q{http://github.com/booster/slicehost-tools/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{tools utilizing the slicehost api}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>, [">= 0.9.8"])
      s.add_runtime_dependency(%q<activeresource>, [">= 2.1.1"])
    else
      s.add_dependency(%q<thor>, [">= 0.9.8"])
      s.add_dependency(%q<activeresource>, [">= 2.1.1"])
    end
  else
    s.add_dependency(%q<thor>, [">= 0.9.8"])
    s.add_dependency(%q<activeresource>, [">= 2.1.1"])
  end
end
