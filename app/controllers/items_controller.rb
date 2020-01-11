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
    if params[:genre_id] != '' || params[:keyword] != '' || params[:brandkeyword] != ''
      brands = Brand.search(params[:brandkeyword])
      searcheditems = Item.search(brands.ids, params[:keyword], params[:genre_id])
      @searcheditems = searcheditems.page(params[:page]).per(30)
      @searchedItemsCount = searcheditems.count
    else 
      @items = Item.all.page(params[:page]).per(30)
      @itemsallcount = Item.all.count
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
