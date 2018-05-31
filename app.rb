require 'sinatra'
require 'sinatra/activerecord'
require './models'

 set :database, 'sqlite3:blogapp.sqlite3'
 set :sessions, true

 def current_user
 	if(session[:user_id])
 		@current_user = User.find(session[:user_id])
 	end
 end


#homepage
get '/' do
  @users = User.all
  @blogs = Blog.all
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
  date = DateTime.now.to_date

  if !session[:user_id]
    redirect '/login'
  else
   current_user = User.find(session[:user_id])
   Blog.create(title: title, content: content, date: date, user_id: current_user.id)
   redirect "/"
  end
end

# Logout functionality
get "/logout" do
	session[:user_id] = nil
	redirect "/"
end

get "/login" do
	erb :'users/login'
end

post "/login" do
	user = User.where(name: params[:name]).first
	if user.password == params[:password]
		session[:user_id] = user.id
		redirect "/"
	else
		redirect "/login"
  end
end

get "/show/:id/profile" do
@user = User.find(params[:id])
erb :'/users/profile'
end

post "/change-blog/:id" do
  blog = Blog.find(params[:id])
  blog.update(title: params[:title], content: params[:content])
  redirect "/"
end
post "/change-user/:id" do
  user = User.find(params[:id])
  user.update(name: params[:name], birthdate: params[:birthdate], password: params[:password])
  redirect "/"
end
post "/destroy/blog/:id" do
  @blog = Blog.find(params[:id])
  @blog.destroy
  redirect "/"
end
post "/destroy/user/:id" do
  session[:user_id] = nil
  @user = User.find(params[:id])
  @user.blogs.each do |b|
    b.destroy
  end
  @user.destroy

  redirect "/"
end
