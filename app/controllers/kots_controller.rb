class KotsController < ApplicationController
  def index
    @kots = Kot.all
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
    params.require(:kot).permit(:addresse, :prix, :quartier, :agence, :nbchambres, :description)
  end

end
