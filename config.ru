require 'sinatra'

set :environment, :production
disable :run

require File.expand_path(File.join(File.dirname(__FILE__), 'bin/home.rb'))
run Sinatra::Application