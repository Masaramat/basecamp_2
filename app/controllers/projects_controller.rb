class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project, only: [:show, :edit, :update, :destroy, :authorize_user!]
    before_action :authorize_user!, only: [:edit, :update, :destroy, :add_user]

    def index
        if current_user.admin?
            @projects = Project.all
        else
            @projects = current_user.projects
        end

    end
    def show
        @project = Project.find(params['id'])
        @topics = @project.topics.order(created_at: :desc).limit(3)
        @project_users = @project.project_users
    end
    def new
        @project = Project.new
    end
    def create
        @project = Project.new(permitted_params)
        
        if @project.save
            project_user = @project.project_users.new(user: current_user, role: :admin)

            if project_user.save
              redirect_to project_path(@project)
            else
              render :new
            end         
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

    def add_user
        @project = Project.find(params[:id])
        user_email = params[:project][:user_email]
        user_role = params[:project][:user_role].to_i
      
        user = User.find_by(email: user_email)
      
        if user
          project_user = @project.project_users.find_by(user_id: user.id)
      
          if project_user
            redirect_to project_path(@project), notice: "#{user.firstname} is already a member of the project."
          else
            @project.users << user
            project_user = @project.project_users.find_by(user_id: user.id)
            project_user.update(role: user_role)
            redirect_to project_path(@project), notice: "#{user.firstname} has been added to the project."
          end
        else
          redirect_to project_path(@project), notice: "User not found. Check email and add again."
        end
      end
      

    protected
    def project_params
        params.require(:project).permit(:name, :user_email, :user_role)
      end

    def permitted_params
        params.require(:project).permit(:name)

    end
    def set_project
        @project = Project.find(params[:id])
    end

    def authorize_user!
        @project = Project.find(params['id'])
        redirect_to root_path, notice: 'Access denied. only Project owner can perform the operation' unless current_user == @project.users.first
    end
end
