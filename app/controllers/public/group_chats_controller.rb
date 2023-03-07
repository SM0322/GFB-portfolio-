class Public::GroupChatsController < ApplicationController
before_action :authenticate_customer!
  def create
    @group = Group.find(params[:group_id])
    @groupchat = current_customer.group_chats.new(group_chats_params)
    @groupchat.group_id = @group.id
    if @groupchat.save
      redirect_to group_path(@group)
    else
      redirect_to group_path(@group), notice: @group_chat.errors.full_messages.first
    end
  end 
  
  def destroy
    GroupChat.find(params[:id]).destroy
    redirect_to request.referer
  end 
  
  private
  
  def group_chats_params
    params.require(:group_chat).permit(:message)
  end
end
