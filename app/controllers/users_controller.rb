class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new.html', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/users/index.html'
    end
  end

  post '/signup' do
    if params[:firstname] == "" || params[:lastname] == "" || params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:firstname => params[:firstname], :lastname => params[:lastname], :username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      erb :"users/index.html"
    end
  end

  
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/'
    else
      redirect to '/'
    end
  end
end
