class ItemsController < ApplicationController
  def index
    if params[:keyword].present?
      empty = ''
      @items = Item.search(empty, params[:keyword], empty).limit(5)
    else
      @items = Item.where(brand_id: params[:brand_id])
    end
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
    if params[:genre_id] != '' || params[:keyword] != '' || params[:brandkeyword] != ''
      brands = Brand.search(params[:brandkeyword])
      searcheditems = Item.search(brands.ids, params[:keyword], params[:genre_id])
      @items = searcheditems.includes(:posts).order("post_items.item_id DESC").page(params[:page]).per(32)
      @itemscount = searcheditems.count
    else 
      @items = Item.includes(:posts).order("post_items.item_id DESC").page(params[:page]).per(30)
      @itemscount = Item.all.count
    end
    if params[:brandkeyword] != ''
      @brandkeyword = params[:brandkeyword]
    end
    if params[:genre_id] && params[:genre_id] != ''
      @genre = Genre.find(params[:genre_id])
    end
    if params[:keyword] != ''
      @keyword = params[:keyword]
    end
  end

end
