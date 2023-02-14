class Public::HomesController < ApplicationController
  def top
    @post_favorite_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    @post_news = Post.order('id DESC').limit(4)
  end

  def about
  end
end
