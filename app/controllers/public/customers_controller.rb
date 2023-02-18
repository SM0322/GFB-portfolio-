class Public::CustomersController < ApplicationController
  before_action :ensure_current_customer, {only: [:edit, :update, :unsubscribe, :withdrawal]}
  
  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result(distinct: true)
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
     redirect_to customer_path(@customer.id)
    else
     render :edit_customer_path
    end 
  end
  
  def favorites
    @customer = Customer.find(params[:id])
    favorites_post_id = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @posts = Post.find(favorites_post_id)
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
    params.require(:customer).permit(:name)
  end 
  
  def ensure_current_customer
    if current_customer.id != params[:id].to_i
      redirect_to customer_path(current_customer.id)
    end
  end 
end