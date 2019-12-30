class BrandsController < ApplicationController
  def index
    @brands = Brand.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end
end
