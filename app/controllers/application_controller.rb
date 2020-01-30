require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "studentportfolios"
  end

  get '/' do
    erb :welcome
  end
  get '/all' do
    @projects = Project.all
    erb :'users/all'
  end
  helpers do

    def authorized_to_edit?(project)
      project.user_id == current_user.id
    end
    
    def redirect_to_login
      if !logged_in? 
        redirect to '/login'
      end
    end

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end
end
