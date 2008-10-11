# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

desc "Recreate db and load initial data for DEV"
task :'db:refresh' => ['db:migrate:reset', 'db:test:load'] do
  ENV["RAILS_ENV"] = "development"
  require "config/environment"
  Stocko::Db::MarketLoader.load_from_directory 'db/raw_data/dowjones', :skip_lines => 1
end