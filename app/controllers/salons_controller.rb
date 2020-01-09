class SalonsController < ApplicationController
  def search
    @salons = Salon.all.page(params[:page]).per(10)
    @salonsallcount = Salon.all.count
  end
  
  def show
    @salon = Salon.find(params[:id])
  end
end
