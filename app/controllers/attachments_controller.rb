class AttachmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user!, only: [:new, :create, :destroy]
    def new
      @project = Project.find(params[:project_id])
      @attachment = Attachment.new
    end
  
    def create
      @attachment = Attachment.new(attachment_params)
      @attachment.user = current_user
      @attachment.project = Project.find(params[:project_id])  
      if @attachment.save
        flash[:notice] = 'Attachment uploaded successfully.'
        redirect_to @attachment.project # Redirect to appropriate path
      else
        render :new
      end
    end

    def destroy
      @project = Project.find(params[:project_id])
      @attachment = Attachment.find(params[:id])
      if @attachment.destroy
        flash[:notice] = 'Attachment deleted successfully.'
        
      else
        flash[:notice] = 'Could not delete attachment.'
      end
      redirect_to @attachment.project # Redirect to appropriate path

    end
  
    private
  
    def attachment_params
        params.require(:attachment).permit(:attachment_name, :attachment_url, :photo)
    end

    def authorize_user!
      @project = Project.find(params[:project_id])
      redirect_to project_path(@project), notice: 'Access denied. only Project Members can perform the operation' unless @project.users.include?(current_user)
  end
  end
  