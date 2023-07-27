# app/controllers/topics_controller.rb

class TopicsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_role, only: [:new, :create]
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
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @project = Project.find(params[:project_id])
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
    @topic = Topic.find(params[:id])
  end

  # PATCH/PUT /topics/:id
  def update
    @topic = Topic.find(params[:id])

    if @topic.update(topic_params)
      redirect_to @topic, notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /topics/:id
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to topics_url, notice: 'Topic was successfully destroyed.'
  end

  private

  def topic_params
    params.require(:topic).permit(:topic)
  end

  def admin_role 
    unless current_user && current_user.role == "admin"
        flash[:alert] = "Only admins can create a thread."
        redirect_to project_topic_path(@project)
    end

  end
end
