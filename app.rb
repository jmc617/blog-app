require 'sinatra'
require 'sinatra/activerecord'
 set :database, 'sqlite3:blogapp.sqlite3'
 set :sessions, true
require './models'

#homepage
get '/' do
  @users = User.all
  erb :'users/index'
end
