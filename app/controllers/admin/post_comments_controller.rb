class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end
  
  private
  
  def post_comments_params
    params.require(:post_comment).permit(:message)
  end
end
