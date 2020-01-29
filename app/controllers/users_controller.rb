class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/new.html', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/users/index.html'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      binding.pry
      @user = User.new(:firstname => params[:firstname], :lastname => params[:lastname], :username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      erb :"users/index.html"
    end
  end

  # GET: /users/new
  get "/users/new" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
