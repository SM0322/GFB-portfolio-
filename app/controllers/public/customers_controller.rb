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
  end

  def unsubscribe
  end
  
  
end
