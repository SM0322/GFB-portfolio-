class Public::CustomersController < ApplicationController
  def index
    @customers = Customer.all
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
  
  private
  
  def customer_params
    params.require(:customer).permit(:name)
  end 
  
end
