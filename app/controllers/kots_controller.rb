class KotsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:search].present?
      if params[:search][:quartier_search].present? && params[:search][:type_kot_search].present? && params[:search][:location_search].present?
        all_kots_1 = Kot.where(disponible: true, quartier: params[:search][:quartier_search], type_kot: params[:search][:type_kot_search])
        all_kots_2 = all_kots_1.near(params[:search][:location_search], 10000, order: :distance)
        @kots = all_kots_2

      elsif params[:search][:type_kot_search].present? && params[:search][:location_search].present?
        all_kots_1 = Kot.where(disponible: true, type_kot: params[:search][:type_kot_search])
        all_kots_2 = all_kots_1.near(params[:search][:location_search], 10000, order: :distance)
        @kots = all_kots_2

      elsif params[:search][:quartier_search].present? && params[:search][:location_search].present?
        all_kots_1 = Kot.where(disponible: true, type_kot: params[:search][:quartier_search])
        all_kots_2 = all_kots_1.near(params[:search][:location_search], 10000, order: :distance)
        @kots = all_kots_2

      elsif params[:search][:quartier_search].present? && params[:search][:type_kot_search].present?
        all_kots_1 = Kot.where(disponible: true, quartier: params[:search][:quartier_search], type_kot: params[:search][:type_kot_search])
        all_kots_2 = all_kots_1.sort_by { |all_kots| all_kots[:addresse].capitalize }
        @kots = all_kots_2

      elsif params[:search][:location_search].present?
        all_kots_1 = Kot.near(params[:search][:location_search], 10000, order: :distance)
        @kots = all_kots_1

      elsif params[:search][:type_kot_search].present?
        all_kots_1 = Kot.where(disponible: true, type_kot: params[:search][:type_kot_search])
        @kots = all_kots_1

      elsif params[:search][:quartier_search].present?
        all_kots_1 = Kot.where(disponible: true, quartier: params[:search][:quartier_search])
        @kots = all_kots_1

      else
        all_kots_1 = Kot.all.sort_by { |all_kots| all_kots[:addresse].capitalize }
        @kots = all_kots_1
        @kots_indisponibles = Kot.where(disponible: false).sort_by { |kots_indisponibles| kots_indisponibles[:addresse].capitalize }
      end
    else
      all_kots_1 = Kot.all.sort_by { |all_kots| all_kots[:addresse].capitalize }
      @kots = all_kots_1
      @kots_indisponibles = Kot.where(disponible: false).sort_by { |kots_indisponibles| kots_indisponibles[:addresse].capitalize }
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
