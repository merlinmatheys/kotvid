class KotsController < ApplicationController
  def index
    @kots = Kot.geocoded

    @markers = @kots.map do |kot|
      {
        lat: kot.latitude,
        lng: kot.longitude
      }
    end
  end

  def show
    @kot = Kot.find(params[:id])
  end

  def new
    @kot = Kot.new
  end

  def create
    @kot = Kot.new(kot_params)
    @kot.save
    # Will raise ActiveModel::ForbiddenAttributesError
    redirect_to kots_path(@kot)
  end


  private

  def kot_params
    params.require(:kot).permit(:addresse, :prix, :quartier, :agence, :nbchambres, :description, photos: [])
  end

end
