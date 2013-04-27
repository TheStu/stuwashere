class StaticsController < ApplicationController
  def home
    @posts = Post.page(params[:page]).order('created_at DESC')
  end

  def about
  end

  def contact
  end

  def results
    @results = PgSearch.multisearch(params[:q])
  end

  def web_design
  end

  def photography
  end
end
