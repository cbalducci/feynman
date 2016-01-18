require "bundler/gem_tasks"
require 'rake'
require 'rspec/core/rake_task'
require 'cane/rake_task'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
   
desc 'Run the full test suite from scratch'
task :default => [:quality, :rspec]
 
RSpec::Core::RakeTask.new do |t|
   t.pattern = 'spec/**/*_spec.rb'
end
 
Cane::RakeTask.new(:quality) do |cane|
   cane.canefile = '.cane'
end
