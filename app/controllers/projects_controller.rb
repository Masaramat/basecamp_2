class ProjectsController < ApplicationController
    before_action :authenticate_user!

    def index
        @projects = Project.all
    end
    def show
        @project = Project.find(params['id'])
    end
    def new
        @project = Project.new
    end
    def create
        @project = Project.new(permitted_params)
        @project.users << current_user
        puts @project
        if @project.save
            redirect_to project_path(@project) 
        else
            render :new
        end
    end
    def edit

    end
    def update
    end

    protected

    def permitted_params
        params.require(:project).permit(:name)

    end
end
