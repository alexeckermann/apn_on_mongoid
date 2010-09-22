require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), 'lib', 'apn_on_mongoid', 'version')

desc 'Run APN on Mongoid unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for APN on Mongoid.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Mongoid'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    root_files = FileList["README.textile", "LICENSE"]
    s.name = "apn_on_mongoid"
    s.version = APN::VERSION.dup
    s.summary = "Apple Push Notification delivery powered by Mongoid"
    s.email = "alex+apn_on_mongoid@alexeckermann.com"
    s.homepage = "http://github.com/alex/apn_on_mongoid"
    s.description = "Apple Push Notification delivery powered by Mongoid"
    s.authors = ['Alex Eckermann', 'all the APN on Rails contributors']
    s.files =  root_files + FileList["{lib}/**/*"]
    s.extra_rdoc_files = root_files
    s.add_dependency("mongoid", "~> 2.0.0.beta.17")
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: gem install jeweler"
end