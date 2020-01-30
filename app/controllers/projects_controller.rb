class ProjectsController < ApplicationController
  get '/projects' do
    redirect_to_login
    erb :'projects/index.html'
  end

  get '/projects/new' do
    redirect_to_login
    erb :'projects/new.html'
  end

  post '/projects' do
    redirect_to_login
      if params[:github] == "" || params[:description] == "" || params[:module] == "" || params[:title] == ""
        redirect to "/projects/new"
      else
        @project = current_user.projects.build(params)
        if @project.save
          redirect to "/projects/#{@project.id}"
        else
          redirect to "/projects/new"
        end
      end
  end

  get '/projects/:id' do
    redirect_to_login
    @project = Project.find_by_id(params[:id])
    redirect to '/projects' if @project == nil
    erb :'projects/show.html'
  end

  get '/projects/:id/edit' do
    redirect_to_login
    @project = Project.find_by_id(params[:id])
    if authorized_to_edit?(@project)
      erb :'projects/edit.html'
    else
      redirect to '/projects'
    end
  end

  patch '/projects/:id' do
    redirect_to_login
      if params[:title] == ""
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
 
  end


  delete '/projects/:id/delete' do
    redirect_to_login
    @project = Project.find_by_id(params[:id])
    if @project && @project.user == current_user
      @project.delete
    end
    redirect to '/projects'
  end

end
