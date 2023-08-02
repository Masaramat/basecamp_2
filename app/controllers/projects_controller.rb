class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def index
        if current_user.admin?
            @projects = Project.all
        else
            @projects = current_user.projects
        end

    end
    def show
        @project = Project.find(params['id'])
        @topics = @project.topics.limit(2)
    end
    def new
        @project = Project.new
    end
    def create
        @project = Project.new(permitted_params)
        @project.users << current_user
        if @project.save
            redirect_to project_path(@project) 
        else
            render :new
        end
    end
    def edit
        @project = Project.find(params[:id])
    end
    def update
        @project = Project.find(params[:id])

        if @project.update(permitted_params)
            redirect_to project_path(@project), notice: 'Project was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        @project.destroy
        redirect_to projects_path, notice: "#{@project.name}, was successfully deleted."
    end

    protected

    def permitted_params
        params.require(:project).permit(:name)

    end
    def set_project
        @project = Project.find(params[:id])
    end

    def authorize_user!
        redirect_to root_path, notice: 'Access denied.' unless current_user == @project.users.first
    end
end
