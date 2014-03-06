require 'rubygems'
require 'sinatra'

set :sessions, true

get '/' do
  "Hello World!!! time 6"
end

get '/dog' do
  erb :dog
end

get '/hotrod' do
  erb :"/cars/used"
end

