class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tags = Tag.all
    if params[:latest]
      @posts = Post.latest.page(params[:page])
    elsif params[:old]
      @posts = Post.old.page(params[:page])
    else
      @posts = Post.order('id DESC').page(params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @posts = @customer.posts.where.not(id: @post.id).order('id DESC').limit(4)
    @tag = @post.tags.all
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.all
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params.merge(rate: params[:rate]))
      flash[:notice] = "変更に成功しました"
      redirect_to admin_post_path
    else
      render:edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
  
  def search_tag
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.order('id DESC').page(params[:page])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:rate, :title, :introduction, tag_ids: [], images: [])
  end
end
