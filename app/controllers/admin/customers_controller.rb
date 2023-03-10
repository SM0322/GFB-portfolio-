class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
     if @customer.update(customer_params)
      flash[:notice] = "変更に成功しました"
      redirect_to admin_customer_path(@customer.id)
     else
      render :edit
     end 
  end
  
  def post_comments
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.all
    @post_comments = @customer.post_comments.all
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image, :email, :is_deleted)
  end
end
