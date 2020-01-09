class SalonsController < ApplicationController
  def search
    @salons = Salon.all.page(params[:page]).per(10)
  end
  
  def show
    @salon = Salon.find(params[:id])
  end
end
