# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Peatio::Application

#require './app.rb'
#run Sinatra::Application