class Public::GroupsController < ApplicationController
#   before_action :authenticate_customer!
#   before_action :ensure_post_customer, {only: [:edit, :update, :destroy]}
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_customer.id
    @group.customers << current_customer
    if @group.save
      flash[:notice] = "グループの作成に成功しました"
      redirect_to groups_path
    else
      render :new
    end 
  end
  
  def index
    @groups = Group.page(params[:page])
  end
  
  def show
    @group = Group.find(params[:id])
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    @group.owner_id = current_customer.id
    if @group.update(group_params)
      flash[:notice] = "変更内容を保存しました"
      redirect_to group_path
    else
      render :edit
    end 
  end
  
  def join
    @group = Group.find(params[:group_id])
    @group.customers << current_customer                                        #<<は追加という意味で現在のユーザをグループのユーザに追加している
    redirect_to  group_path(@group)
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.customers.delete(current_customer)                                           #current_userは、@group.usersから消されるという記述。
    redirect_to group_path
  end
  
  def new_mail
    @group = Group.find(params[:group_id])
  end

  def send_mail
    @group = Group.find(params[:group_id])
    group_customers = @group.customers
    @mail_title = params[:mail_title]
    @mail_content = params[:mail_content]
    ContactMailer.send_mail(@mail_title, @mail_content,group_customers).deliver
  end
  
  private
  
  def group_params
    params.require(:group).permit(:group_image, :name, :introduction)
  end
  
#   def ensure_post_customer
#     @post = Post.find(params[:id])
#     if current_customer.id != @post.customer_id
#       redirect_to post_path(@post)
#     end
#   end  
end
