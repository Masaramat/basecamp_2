class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user!, only: [:create]
    before_action :authorize_owner!, only: [:edit, :update, :destroy]
    def create
        @topic = Topic.find(params[:topic_id])
        @message = @topic.messages.new(message_params)
        @message.user = current_user

        if @message.save
            redirect_to project_topic_path(@project, @topic), notice: "Message sent successfully!"
        else
            redirect_to project_topic_path(@project, @topic), notice: "Message not sent successfully!"
        end
    end

    # GET /topics/:id/edit
    def edit    
        @project = Project.find(params[:project_id])
        @topic = @project.topics.find(params[:topic_id])
        @message = Message.find(params[:id])
        
    end

    # PATCH/PUT /topics/:id
    def update
        @project = Project.find(params[:project_id])
        @topic = Topic.find(params[:topic_id])
        @message = Message.find(params[:id])

        if @message.update(message_params)
            redirect_to project_topic_path(@project, @topic), notice: 'Message was successfully updated.'
        else
            redirect_to project_topic_path(@project, @topic), notice: 'Unable to update message.'
        end
    end

    def destroy
        @project = Project.find(params[:project_id])
        @topic = @project.topics.find(params[:topic_id])
        @message = Message.find(params[:id])
        @message.destroy

        redirect_to project_topic_path(@project, @topic, anchor: 'message-form'), notice: 'Message was successfully deleted.'

    end

    private

    def message_params
        params.require(:message).permit(:content)
    end

    def authorize_user!
        @topic = Topic.find(params[:topic_id])
        @project = @topic.project
        
        # Check if the project exists and the current user is associated with the project
        if @project && @project.users.include?(current_user)
          return
        end
        redirect_to project_topic_path(@project, @topic), notice: "Only members of a project can send message."
      end

      def authorize_owner!
        @message = Message.find(params[:id])
        if current_user == @message.user
            return
        end
        redirect_to project_topic_path(@project, @topic), notice: "Message must belong to you to be able to alter."

      end
end
