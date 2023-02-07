class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comments_params)
    @post_comment.post_id = @post.id
    @post_comment.save
    redirect_to request.referer
  end
  
  private
  
  def post_comments_params
    params.require(:post_comment).permit(:message)
  end
end
