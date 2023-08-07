class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user!, only: [:create, :edit, :update, :destroy]
    def create
        @topic = Topic.find(params[:topic_id])
        @message = @topic.messages.new(message_params)
        @message.user = current_user

        if @message.save
            p "Message: #{@message.content}"
            redirect_to project_topic_path(@project, @topic), notice: "Message sent successfully!"
        else
            redirect_to project_topic_path(@project, @topic), notice: "Message not sent successfully!"
        end
    end

    def edit

    end

    def update

    end

    def destroy

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
end
