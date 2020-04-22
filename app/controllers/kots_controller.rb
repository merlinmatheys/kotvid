class KotsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:location].present?
      # @kots = Kot.near(params[:location], 10000, order: :distance)
      @kots_triés = Kot.near(params[:location], 10000, order: :distance)
    else
      all_kots = Kot.where(disponible: nil) + Kot.where(disponible: true)
      @kots = all_kots.sort_by { |all_kots| all_kots[:addresse].capitalize }
      kots_indisponibles = Kot.where(disponible: false)
      @kots_indisponibles = kots_indisponibles.sort_by { |kots_indisponibles| kots_indisponibles[:addresse].capitalize }
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
    if @kot.valid?
      @kot.save
      redirect_to root_path
    end
  end

  def edit
    @kot = Kot.find(params[:id])
  end

  def update
    @kot = Kot.find(params[:id])
    if @kot.user_id == current_user.id || current_user.id == 1 || current_user.id == 2 || current_user.id == 3
    @kot.update(kot_params)
    redirect_to kot_path(@kot)
    end
  end

  def destroy
    @kot = Kot.find(params[:id])
    if @kot.user_id == current_user.id || current_user.id == 1 || current_user.id == 2 || current_user.id == 3
    @kot.destroy
    redirect_to root_path
    end
  end


  private

  def kot_params
    params.require(:kot).permit(:addresse, :quartier, :nombre_chambres, :user_id, :type_kot, :agence, :disponible, photos: [])
  end

end
