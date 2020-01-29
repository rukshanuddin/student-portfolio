class ProjectsController < ApplicationController
  get '/projects' do
    if logged_in?
      @projects = Project.all
      erb :'projects/index.html'
    else
      redirect to '/login'
    end
  end

  get '/projects/new' do
    if logged_in?
      erb :'projects/new.html'
    else
      redirect to '/login'
    end
  end

  post '/projects' do
    if logged_in?
      if params[:github] == "" || params[:description] == "" || params[:module] == "" || params[:title] == ""
        redirect to "/projects/new"
      else
        
        @project = Project.create(:title => params[:title], :module => params[:module], :github => params[:github], :description => params[:description], :user_id => current_user.id)
        binding.pry
        if @project.save
          redirect to "/projects/#{@project.id}"
        else
          redirect to "/projects/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/projects/:id' do
    if logged_in?
      @project = Project.find_by_id(params[:id])
      erb :'projects/show.html'
    else
      redirect to '/login'
    end
  end

  get '/projects/:id/edit' do
    if logged_in?
      @project = Project.find_by_id(params[:id])
      if @project && @project.user == current_user
        erb :'projects/edit.html'
      else
        redirect to '/projects'
      end
    else
      redirect to '/login'
    end
  end

  patch '/projects/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/projects/#{params[:id]}/edit"
      else
        @project = Project.find_by_id(params[:id])
        if @project && @project.user == current_user
          if @project.update(:title => params[:title], :module => params[:module], :github => params[:github], :description => params[:description])
            redirect to "/projects/#{@project.id}"
          else
            redirect to "/projects/#{@project.id}/edit"
          end
        else
          redirect to '/projects'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/projects/:id/delete' do
    if logged_in?
      @project = Project.find_by_id(params[:id])
      if @project && @project.user == current_user
        @project.delete
      end
      redirect to '/project'
    else
      redirect to '/login'
    end
  end

  # # GET: /projects
  # get "/projects" do
  #   erb :"/projects/index.html"
  # end

  # # GET: /projects/new
  # get "/projects/new" do
  #   erb :"/projects/new.html"
  # end

  # # POST: /projects
  # post "/projects" do
  #   redirect "/projects"
  # end

  # # GET: /projects/5
  # get "/projects/:id" do
  #   erb :"/projects/show.html"
  # end

  # # GET: /projects/5/edit
  # get "/projects/:id/edit" do
  #   erb :"/projects/edit.html"
  # end

  # # PATCH: /projects/5
  # patch "/projects/:id" do
  #   redirect "/projects/:id"
  # end

  # # DELETE: /projects/5/delete
  # delete "/projects/:id/delete" do
  #   redirect "/projects"
  # end
end
