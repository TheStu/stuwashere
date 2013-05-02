class StaticsController < ApplicationController
  def home
    @posts = Post.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  def about
  end

  def contact
  end

  def results
    @results = PgSearch.multisearch(params[:q]).paginate(:page => params[:page], :per_page => 10)
  end

  def web_design
  end

  def photography
  end
end
