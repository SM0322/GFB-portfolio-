class Public::PostsController < ApplicationController
  before_action :ensure_post_customer, {only: [:edit, :update, :destroy]}
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params.merge(rate: params[:rate]))
    @post.customer_id = current_customer.id
    tag_list=params[:post][:name].split(',')         #splitは()の中の引数により文字列を分割し、分割された各文字列を要素としている。今回は「'」で区切られた文字列を要素としている。
    @post.save
    @post.save_tag(tag_list)                         #modelファイルにて定義されたメソッド
    redirect_to posts_path
  end 

  def index
    @tags = Tag.all
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    else
      @posts = Post.all
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
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params.merge(rate: params[:rate]))
      PostTag.where(post_id: @post.id).destroy_all
      @post.save_tag(tag_list)
      redirect_to post_path
    else
      render:edit
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
    @posts = @tag.posts.all
  end 
  
  private
  
  def post_params
    params.require(:post).permit(:rate, :title, :introduction, images: [])
  end
  
  def ensure_post_customer
    @post = Post.find(params[:id])
    if current_customer.id != @post.customer_id
      redirect_to post_path(@post)
    end
  end  
end