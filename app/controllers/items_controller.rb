class ItemsController < ApplicationController
  def index
    @items = Item.where(brand_id: params[:brand_id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    @items = Item.all.page(params[:page]).per(100)
  end

end
