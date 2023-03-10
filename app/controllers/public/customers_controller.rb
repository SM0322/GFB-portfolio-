class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_current_customer, {only: [:edit, :update, :unsubscribe, :withdrawal]}
  
  def index
    @customers = Customer.order('id DESC').page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order('id DESC').page(params[:page])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     flash[:notice] = "変更に成功しました"
     redirect_to customer_path(@customer.id)
    else
     render :edit
    end 
  end
  
  def favorites
    @customer = Customer.find(params[:id])
    favorites_post_id = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @posts = Post.joins(:favorites).includes(:favorites).order('favorites.id DESC').where(id: favorites_post_id).page(params[:page])
  end
  
  def follow_posts
    @posts = Post.where(customer_id: [*current_customer.following_ids]).order('id DESC').page(params[:page])
  end

  def unsubscribe
  end
  
  def withdrawal
    customer = Customer.find(params[:id])
    customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end 
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end 
  
  def ensure_current_customer
    if current_customer.id != params[:id].to_i
      redirect_to customer_path(current_customer.id)
    end
  end 
end