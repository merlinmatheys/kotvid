
# web harvesting

    require 'open-uri'
    require 'nokogiri'
    require 'watir'

    browser = Watir::Browser.new(:chrome)
    browser.goto('https://louer.eckelmans.net/notre-offre-2')

    browser.execute_script('document.querySelector("select").value="E"')
    browser.execute_script('document.querySelector("select").onchange()')
    browser.execute_script('document.querySelectorAll("select")[1].value="8"')
    browser.execute_script('document.querySelectorAll("select")[1].onchange()')
    21.times do
      browser.link(text: 'Afficher la suite').click
      # browser.execute_script('document.querySelectorAll("a")[20].onclick()')
      browser.element(text: 'Afficher la suite').wait_until(&:present?)
    end
    sleep(2)

    puts html_file = browser.body.inner_html
    html_doc = Nokogiri::HTML(html_file)
    array = []
    html_doc.xpath(' //*[@class="bienSummary"]/div[6]').each do |element|
      array << element
      puts element.text
    end
    puts array.count

    array = []
    something = browser.element(css: 'h1')
    puts html_doc = Nokogiri::HTML(something)

    url = 'https://louer.eckelmans.net/notre-offre-2/'
    html_file = open(url,{ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read


    liens = []
    array = (958..2830)
    array.each do |element|
      liens << "https://louer.eckelmans.net/bien/?bienid=#{element}"
    end
    liens.each do |lien|
      url = lien
      html_file = open(url,{ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read
      html_doc = Nokogiri::HTML(html_file)
      adresse_incorrecte = html_doc.xpath(' //*[@class="bienDetail2"]/div/div/div[5]').text.strip.upcase_first
      if adresse_incorrecte.include? "LOUVAIN-LA-NEUVE"
        adresse_début = adresse_incorrecte[/[^\d]+/]
        numero_postal = html_doc.xpath(' //*[@class="bienDetail2"]/div/div/div[4]').text.strip.split.last
        puts adresse = "#{adresse_début}#{numero_postal} - Louvain-La-Neuve"
        type_incorrect = html_doc.xpath(' //*[@class="bienDetail2"]/div/div/h2').text.strip[0...-21].downcase
        if type_incorrect.match(/kot/)
          type = "Kot"
        elsif type_incorrect.match(/studio/)
          type = "Studio"
        else
          type = ""
        end
        puts type
        puts quartier = "NC"
        puts nombre_chambres = 1
        puts propriétaire = "Eckelmans"
        puts disponible = true
        # photos = []
        # html_doc.search('.container').css('img').each do |element|
        #   if element['src'].match(/^https:\/\/louer.eckelmans.net\/wp-content\/uploads\/esimmo\/bien/)
        #     puts element['src']
        #     photos << element['src']
        #   end
        # end
        kot = Kot.create!(addresse: adresse, user_id: 1, type_kot: type, quartier: quartier, nombre_chambres: nombre_chambres, agence: propriétaire, disponible: disponible)
        # photos.each do |photo|
        #   file = URI.open(photo,{ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE})
        #   kot.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')
        # end
      end
    end


























