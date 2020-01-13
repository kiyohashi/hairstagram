class BrandsController < ApplicationController
  def index
    if params[:keyword] != ''
      @brands = Brand.postsearch(params[:keyword]).limit(5)
    end
    respond_to do |format|
      format.html
      format.json
    end
  end
end
