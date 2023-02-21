class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
    post = Post.find(params[:post_id])
    post_comment = current_customer.post_comments.new(post_comments_params)
    post_comment.post_id = post.id
    if post_comment.save
      redirect_to request.referer
    else
      render :'posts#show'         #post/:idやshowではだめ
    end
  end 
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end 
  
  private
  
  def post_comments_params
    params.require(:post_comment).permit(:message)
  end
end
