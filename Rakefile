# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

environments = {'dev' => 'development', 'test' => 'test', 'int' => 'integration', 'prod' => 'production'}

environments.each do |short_name, name|
  desc "Set environment to #{name}"
  task :"env:#{short_name}" do
    RAILS_ENV = name
    require "config/environment"
  end
  
  desc "Reset #{name} database"
  task :"db:#{short_name}:reset" => [:"env:#{short_name}", :"db:migrate:reset"] do
    if ['dev', 'int'].include? short_name
      Rake::Task["db:#{short_name}:load"].invoke
    end
  end
end

desc "Load data into development database"
task :"db:dev:load" => ["env:dev", "db:migrate:reset"] do
  Stocko::Db::MarketLoader.load_from_directory 'db/raw_data/dowjones', :skip_lines => 1
end

desc "Load data into integration database"
task :"db:int:load" => ["env:int", "db:migrate:reset"] do
  Stocko::Db::MarketLoader.load_from_directory 'spec/fixtures/integration/dowjones', :skip_lines => 1
end