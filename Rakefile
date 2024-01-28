require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test_mri) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :test_opal do
  require 'opal'
  ENV['RUBYOPT'] += ' -rbundler/setup -ropal-jquery'
  files = nil
  cd('test-opal') do
    files = Dir['**/*_test.rb'].map{|f| "-r#{f.shellescape}"}
  end
  sh "opal -Ilib-opal -gminitest -rminitest -setc -srubygems -stempfile -Itest-opal #{files.join(' ')} -e ':done'"
end

task :test => [:test_mri, :test_opal]

task :default => :test
