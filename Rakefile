require 'jeweler'
require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include('pkg/*')

Jeweler::Tasks.new do |gem|
  gem.name        = 'captchr'
  gem.summary     = 'sends (mostly) non-identifying information from you to us!'
  gem.description = 'ever wonder why your rubygems.org download count goes up by 100 within an hour of a new version? we did too.'
  gem.email       = ['conor.code@gmail.com']
  gem.homepage    = 'http://github.com/chorankates/captchr'
  gem.authors     = ['Conor Horan-Kates', 'Maureen Long']
  gem.licenses    =  'MIT'

end
Jeweler::RubygemsDotOrgTasks.new

namespace :test do
  Rake::TestTask.new do |t|
    t.name = 'unit'
    t.libs << 'lib'
    t.test_files = FileList['test/**/test_*.rb']
    t.verbose = true
  end
end

desc 'run all tests'
task :test => ['test:unit'] do; end

desc 'run Home'
task :home do
  sh 'ruby bin/home.rb'
end