require 'rubygems'
require 'rake'
require 'rake/gempackagetask'

gem_spec = Gem::Specification.new do |s|
  s.name = %q{slicehost-tools}
  s.version = "0.0.12"
 
  s.specification_version = 2 if s.respond_to? :specification_version=
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Cameron Cox", "Bobby Uhlenbrock", "Corey Martella"]
  s.date = %q{2008-09-10}
  s.summary = %q{tools utilizing the slicehost api}
  s.email = %q{cameroncox@gmail.com}
  s.executables = ["slicehost-dns", "slicehost-slice"]
  s.extra_rdoc_files = ["README.markdown", "LICENSE"]
  s.files = Dir['**/**'].reject{ |f| f =~ /pkg/i }
  s.has_rdoc = false
  s.homepage = %q{http://github.com/booster/slicehost-tools/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.1.1}
  s.add_dependency("thor", ">= 0.9.8")
  s.add_dependency("activeresource", ">= 2.1.1")
end

Rake::GemPackageTask.new(gem_spec) do |p|
  p.gem_spec = gem_spec
  p.need_tar = true
  p.need_zip = true
end

namespace :gem do
  namespace :spec do
    desc "Update slicehost-tools.gemspec"
    task :generate do
      File.open("slicehost-tools.gemspec", "w") do |f|
        f.puts(gem_spec.to_ruby)
      end
    end
  end
end