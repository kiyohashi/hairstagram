class SalonsController < ApplicationController

  def index
    if params[:keyword].present?
      @salons = Salon.search(params[:keyword], params[:area_id]).limit(5)
    end
    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    if params[:area_id] != '' || params[:keyword] != ''
      @searchedsalons = Salon.search(params[:keyword], params[:area_id]).page(params[:page]).per(10)
      @searchedSalonsCount = Salon.search(params[:keyword], params[:area_id]).count
    else 
      @salons = Salon.all.page(params[:page]).per(10)
      @salonsallcount = Salon.all.count
    end
    if params[:area_id] && params[:area_id] != ''
      @area = Area.find(params[:area_id])
    end
    if params[:keyword] != ''
      @keyword = params[:keyword]
    end
  end
  
  def show
    @salon = Salon.find(params[:id])
  end
end
