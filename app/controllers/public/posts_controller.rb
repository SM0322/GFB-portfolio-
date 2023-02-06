class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    tag_list=params[:post][:name].split(',')         #splitは()の中の引数により文字列を分割し、分割された各文字列を要素としている。今回は「'」で区切られた文字列を要素としている。
    @post.save
    @post.save_tag(tag_list)                         #modelファイルにて定義されたメソッド
    redirect_to public_posts_index_path
  end 

  def index
    @posts = Post.all
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    @tag = @post.tags.pluck(:name).join(',')
  end
  
  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    @post.update(post_params)
    @post.save_tag(tag_list)
    redirect_to public_post_path
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_index_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :introduction)
  end 
end
