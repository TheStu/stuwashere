class StaticsController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def results
    @results = PgSearch.multisearch(params[:q])
  end
end
