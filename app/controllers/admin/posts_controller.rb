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
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params.merge(rate: params[:rate]))
      PostTag.where(post_id: @post.id).destroy_all
      @post.save_tag(tag_list)
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
    @posts = @tag.posts.all
  end
  
  private
  
  def post_params
    params.require(:post).permit(:rate, :title, :introduction, images: [])
  end
end
