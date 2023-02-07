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
    redirect_to posts_path
  end 

  def index
    @posts = Post.all
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @tag = @post.tags.all
  end

  def edit
    @post = Post.find(params[:id])
    @tag = @post.tags.map(&:name).join(',')
  end
  
  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params)
      @old_relations = PostTag.where(post_id: @post.id)
      @old_relations.each do |relation|
        relation.delete
      end 
      @post.save_tag(tag_list)
      redirect_to post_path
    else
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
    params.require(:post).permit(:title, :introduction)
  end 
end
