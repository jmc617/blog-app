require 'sinatra'
require 'sinatra/activerecord'
 set :database, 'sqlite3:blogapp.sqlite3'
 set :sessions, true
require './models'

get "/signup" do
  erb :'/signup'
end

post "/create-user" do
  username = params[:username]
  password = params[:password]
  birthdate = params[:birthdate]

  User.create(name: username, password: password, birthdate: birthdate)
  #change redirect to home when created
  redirect "/signup"
end
