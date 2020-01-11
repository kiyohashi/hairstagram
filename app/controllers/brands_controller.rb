class BrandsController < ApplicationController
  def index
    @brands = Brand.postsearch(params[:keyword]).limit(5)
    respond_to do |format|
      format.html
      format.json
    end
  end
end
