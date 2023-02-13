class Admin::TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.all
  end
  
  def create
    tag = Tag.new(tag_params)
    tag.save
    redirect_back(fallback_location: admin_tags_path)
  end 
  
  private
  
  def tag_params
    params.require(:tag).permit(:name)
  end 
end
