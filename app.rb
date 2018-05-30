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

get "/signup" do
  erb :'users/signup'
end

post "/create-user" do
  username = params[:username]
  password = params[:password]
  birthdate = params[:birthdate]

  User.create(name: username, password: password, birthdate: birthdate)
  redirect "/"
end

get "/newPost" do
  erb :'posts/newposts'
end

post "/create-blog" do
  title = params[:title]
  content = params[:content]
  date = DateTime.now

  Blog.create(title: title, content: content, date: date)

  redirect "/"
end
