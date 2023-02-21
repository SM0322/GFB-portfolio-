class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comments_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      redirect_to post_path(@post)
    else
      @customer = @post.customer
      @posts = @customer.posts.where.not(id: @post.id).order('id DESC').limit(4)
      @tag = @post.tags.all
      @post_comments = @post.post_comments.all
      render template: "public/posts/show"
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
