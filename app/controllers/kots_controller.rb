class KotsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:location].present?
      @kots = Kot.near(params[:location], 10000, order: :distance)
    else
      @kots = Kot.all
    end

    # @markers = @kots.map do |kot|
    #   {
    #     lat: kot.latitude,
    #     lng: kot.longitude
    #   }
    # end
  end

  def show
    @kot = Kot.find(params[:id])
  end

  def new
    @kot = Kot.new
  end

  def create
    @kot = Kot.new(kot_params)
    if @kot.valid?
      @kot.save
      redirect_to kots_path
    end
  end

  def edit
    @kot = Kot.find(params[:id])
  end

  def update
    if @kot.user_id == current_user.id
    @kot = Kot.update(kot_params)
    redirect_to kot_path(@kot)
    end
  end

  def destroy
    @kot = Kot.find(params[:id])
    if @kot.user_id == current_user.id
    @kot.destroy
    redirect_to root_path
    end
  end


  private

  def kot_params
    params.require(:kot).permit(:addresse, :prix, :quartier, :agence, :nbchambres, :description, :user_id, photos: [])
  end

end
