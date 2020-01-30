class UsersController < ApplicationController

  get '/users' do
    redirect_to_login
    @projects = Project.all
    erb :'users/all'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new.html', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/home'
    end
  end

  get '/home' do
    redirect_to_login
    @user = current_user
    erb :'users/index.html'
  end

  post '/signup' do
    if params[:firstname] == "" || params[:lastname] == "" || params[:username] == "" || params[:password] == "" || User.find_by(:username => params[:username])
      redirect to '/signup'
    else
      @user = User.new(:firstname => params[:firstname], :lastname => params[:lastname], :username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/home'
    end
  end

  
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/home'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/home'
    else
      redirect to '/login'
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
