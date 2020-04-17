class KotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:location].present?
      @kots = Kot.near(params[:location], params[:distance] || 10, order: :distance)
    else
      @kots = Kot.all
    end

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
    redirect_to kots_path
  end


  private

  def kot_params
    params.require(:kot).permit(:addresse, :prix, :quartier, :agence, :nbchambres, :description, photos: [])
  end

end
