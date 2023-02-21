class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @post_favorite_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(4).pluck(:post_id))
    @post_news = Post.where.not(id: @post_favorite_ranks.pluck(:id)).order('id DESC').limit(4)
  end
end
