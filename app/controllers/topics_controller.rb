# app/controllers/topics_controller.rb

class TopicsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update, :destroy, :authorize_user!]
    before_action :authenticate_user!
    before_action :authorize_user!, only: [:new, :create]
  # GET /topics
  def index
    if params[:project_id].present?
      @project = Project.find(params[:project_id])
      @topics = @project.topics
    else
      @topics = Topic.all
    end
  end

  # GET /topics/:id
  def show
    @topic = Topic.find(params[:id])
    @project = Project.find(params[:project_id])
    @messages = @topic.messages
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @project = Project.find(params[:project_id])
    p @project
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)  
    @topic.user = current_user
    @topic.project = Project.find(params[:project_id]) 

    if @topic.save
      redirect_to project_topic_path(@topic.project, @topic), notice: 'Topic was successfully created.'
    else
      flash[:error] = @topic.errors.full_messages.join(", ")
      render :new
    end
  end

  # GET /topics/:id/edit
  def edit
    
    @project = Project.find(params[:project_id])
    @topic = @project.topics.find(params[:id])
    
  end

  # PATCH/PUT /topics/:id
  def update
    @project = Project.find(params[:project_id])
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      redirect_to project_topic_path(@project, @topic), notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /topics/:id
  def destroy
    @project = Project.find(params[:project_id])
    @topic = @project.topics.find(params[:id])
    @topic.destroy
  
    # Optionally, you can redirect to a different page after the delete.
    # For example, redirect back to the project's topics list:
    redirect_to project_topics_path(@project), notice: "Topic was successfully deleted."
  end

  private

  def topic_params
    params.require(:topic).permit(:topic)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def authorize_user!
    @project = Project.find_by(id: params[:project_id])
    
    # Check if the project exists and the current user is associated with the project
    if @project && @project.users.include?(current_user)
      # Check the role of the current user within the project
      project_user = @project.project_users.find_by(user: current_user)
      if project_user.admin?
        # Current user is an admin, allow access
        return
      end
    end
    redirect_to project_path(@project), notice: "Only project admins can create a thread."
  end
end
