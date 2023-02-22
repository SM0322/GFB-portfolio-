class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_post_customer, {only: [:edit, :update, :destroy]}
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_customer.posts.build(post_params.merge(rate: params[:rate]))
    if @post.save
      flash[:notice] = "投稿に成功しました"
      redirect_to posts_path
    else
      render :new
    end 
  end 

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
    @tag = @post.tags.map(&:name).join(',')
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params.merge(rate: params[:rate]))
      flash[:notice] = "変更に成功しました"
      redirect_to post_path
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
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
  
  def ensure_post_customer
    @post = Post.find(params[:id])
    if current_customer.id != @post.customer_id
      redirect_to post_path(@post)
    end
  end  
end