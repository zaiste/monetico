require "bundler"
Bundler.setup

require "rspec"

Dir[File.expand_path(File.dirname(__FILE__) + "/../lib/**/*.rb")].each { |f| require f }