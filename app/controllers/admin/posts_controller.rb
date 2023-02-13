class Admin::PostsController < ApplicationController
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @posts = @customer.posts.order('id DESC').limit(4)
    @tag = @post.tags.all
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path
    else
      render:edit
    end
  end
end
