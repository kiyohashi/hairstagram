class SalonsController < ApplicationController
  def index
    @salons = Salon.all.page(params[:page]).per(10)
  end
  
  def show
    @salon = Salon.find(params[:id])
  end
end
