class KotsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:search].present?
      if params[:search][:quartier_search].present? && params[:search][:type_kot_search].present? && params[:search][:location_search].present?
        @kots = Kot.near(params[:search][:location_search], 10000, order: :distance).where(disponible: true, quartier: params[:search][:quartier_search], type_kot: params[:search][:type_kot_search]) + Kot.where(disponible: nil, quartier: params[:search][:quartier_search], type_kot: params[:search][:type_kot_search])

      elsif params[:search][:type_kot_search].present? && params[:search][:location_search].present?
        @kots = Kot.near(params[:search][:location_search], 10000, order: :distance).where(disponible: true, type_kot: params[:search][:type_kot_search]) + Kot.where(disponible: nil, type_kot: params[:search][:type_kot_search])

      elsif params[:search][:quartier_search].present? && params[:search][:location_search].present?
        @kots = Kot.near(params[:search][:location_search], 10000, order: :distance).where(disponible: true, quartier: params[:search][:quartier_search]) + Kot.where(disponible: nil, quartier: params[:search][:quartier_search])

      elsif params[:search][:quartier_search].present? && params[:search][:type_kot_search].present?
        all_kots_1 = Kot.where(disponible: true, quartier: params[:search][:quartier_search], type_kot: params[:search][:type_kot_search]) + Kot.where(disponible: nil, quartier: params[:search][:quartier_search], type_kot: params[:search][:type_kot_search])
        @kots = all_kots_1.sort_by { |all_kots| all_kots[:addresse].capitalize }

      elsif params[:search][:location_search].present?
        @kots = Kot.near(params[:search][:location_search], 10000, order: :distance)

      elsif params[:search][:type_kot_search].present?
        @kots = Kot.where(disponible: true, type_kot: params[:search][:type_kot_search]) + Kot.where(disponible: nil, type_kot: params[:search][:type_kot_search])

      elsif params[:search][:quartier_search].present?
        @kots = Kot.where(disponible: true, quartier: params[:search][:quartier_search]) + Kot.where(disponible: nil, quartier: params[:search][:quartier_search])

      else
        all_kots = Kot.where(disponible: true) + Kot.where(disponible: nil)
        @kots = all_kots.sort_by { |all_kots| all_kots[:addresse] }
        @kots_indisponibles = Kot.where(disponible: false).sort_by { |kots_indisponibles| kots_indisponibles[:addresse].capitalize }
      end
    else
      all_kots = Kot.where(disponible: true) + Kot.where(disponible: nil)
      @kots = all_kots.sort_by { |all_kots| all_kots[:addresse] }
      @kots_indisponibles = Kot.where(disponible: false).sort_by { |kots_indisponibles| kots_indisponibles[:addresse].capitalize }
    end

    @kots_geocoded = Kot.geocoded # returns flats with coordinates

    @markers = @kots_geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
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

  def aiglon_populer
    require 'open-uri'
    require 'nokogiri'
    url = "http://www.aiglon.be/prev-etudiants.cfm?fbclid=IwAR39osuYj2n6CFhTLu4j7zjfT7NNO_L6or3TtM47sq_0resNehZ-UvwcHac"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    liens = []
    array = html_doc.xpath('//a/@href').drop(17).reverse.drop(16).reverse
    array = array.reject {|v| array.index(v).odd?}
    array.each do |element|
      liens << "http://www.aiglon.be/#{element}"
    end
    liens.each do |lien|
      url = lien
      html_file = open(url).read
      html_doc = Nokogiri::HTML(html_file)
      adresse = html_doc.search('.listing-address').text.strip
      type = html_doc.search('.basic-table')[1].css('tbody').css('tr')[0].css('td')[3].text.strip
      quartier = html_doc.search('.basic-table').css('tbody').css('tr')[1].css('td')[3].text.strip
      nombre_chambres = 1
      propriétaire = "L'aiglon"
      disponible = true
      photos = []
      puts html_doc.css('img')[2]
      html_doc.search('.container').css('img').each do |element|
        if element['src'].match(/^images\/projects/)
          photos << "http://www.aiglon.be/#{element['src']}"
        end
      end
      kot = Kot.create!(addresse: adresse, user_id: 1, type_kot: type, quartier: quartier, nombre_chambres: nombre_chambres, agence: propriétaire, disponible: disponible)
      photos.each do |photo|
        file = URI.open(photo)
        kot.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
      end
    end
    redirect_to root_path
  end

  def aiglon_update
    all_kots = Kot.where(agence: "L'aiglon")

    require 'open-uri'
    require 'nokogiri'
    url = "http://www.aiglon.be/prev-etudiants.cfm?fbclid=IwAR39osuYj2n6CFhTLu4j7zjfT7NNO_L6or3TtM47sq_0resNehZ-UvwcHac"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    liens = []
    array = html_doc.xpath('//a/@href').drop(17).reverse.drop(16).reverse
    array = array.reject {|v| array.index(v).odd?}
    array.each do |element|
      liens << "http://www.aiglon.be/#{element}"
    end
    adresses = []
    liens.each do |lien|
      url = lien
      html_file = open(url).read
      html_doc = Nokogiri::HTML(html_file)
      adresses << html_doc.search('.listing-address').text.strip

    end
    all_kots.each do |kot|
      if adresses.include? kot.addresse
        kot.update(disponible: true)
      else
        kot.update(disponible: false)
      end
    end

    redirect_to root_path
  end


  private

  def kot_params
    params.require(:kot).permit(:addresse, :quartier, :nombre_chambres, :user_id, :type_kot, :agence, :disponible, photos: [])
  end

end
