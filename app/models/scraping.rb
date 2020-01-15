require 'mechanize'

class Scraping
  def self.omotesandoSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macJR/salon/sacX009/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 1
    
    salon.save
  end

  def self.harajukuMeizizinguSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macJR/salon/sacX010/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 2
    
    salon.save
  end

  def self.aoyamaGaiendooriSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macJR/salon/sacX566/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 3
    
    salon.save
  end

  def self.daikanyamaNakameguroSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macAE/salon/sacX567/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 4
    
    salon.save
  end

  def self.ziyugaokaGakugeidaigakuSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macAE/salon/sacX012/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 5
    
    salon.save
  end

  def self.hiyoshiTunashimaOokurayamaKikunaSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macAE/salon/sacX048/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 6
    
    salon.save
  end

  def self.musashikosugiEtcSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macAE/salon/sacX172/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 7
    
    salon.save
  end


  def self.centargaiEtcSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macAD/salon/sacX007/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 8
    
    salon.save
  end

  def self.miyamasuzakaEtcSalons_urls
    agent = Mechanize.new
    
    links = [] 
    next_url = ''
    last_url = ''
    
    while true
      current_page = agent.get('https://beauty.hotpepper.jp/svcSA/macAD/salon/sacX111/' + last_url)
      
      elements = current_page.search('.slcHeadContentsInner a')
      elements.each do |ele|
        links << ele.get_attribute(:href)
      end
      
      next_link = current_page.at('.paging .afterPage a')
      break unless next_link
      next_url = next_link.get_attribute(:href)
      next_urls = next_url.split("/")
      last_url = next_urls[next_urls.length - 1]
      sleep(1)
    end
    
    links.each do |link|
      get_salon(link)
      sleep(1)
    end
  end

  def self.get_salon(link)
    agent = Mechanize.new
    page = agent.get(link)
    
    name = page.at('.detailTitle a').inner_text if page.at('.detailTitle a')
    nameKana = page.at('.sprtHeaderInner .fs10').inner_text if page.at('.sprtHeaderInner .fs10')
    address =  page.at('.fs10 > li:first-child').inner_text if page.at('.fs10 > :first-child')
    access =  page.at('.fs10 > li:last-child').inner_text if page.at('.fs10 > li:last-child')
    image_url = page.at('.slnTopImgViewer img')[:src] if page.at('.slnTopImgViewer img')
    introduction = page.at('.slnTopImgDescription p').inner_text if page.at('.slnTopImgDescription p')
    
    # first_or_initializeメソッドでbooksテーブルのタイトルカラムに特定のタイトルが存在しなければ新たにインスタンスを作成する
    salon = Salon.where(name: name).first_or_initialize
    salon.nameKana = nameKana
    salon.address = address
    salon.access = access 
    salon.image_url = image_url
    salon.introduction = introduction
    salon.link = link
    salon.area_id = 9
    
    salon.save
  end








  def self.appliancesBrands
    agent = Mechanize.new
    
    page = 0

    while true
      current_page = agent.get("https://cosmeet.cosme.net/brand/search/page/#{page}/itm/1065/trg/8")
      
      elements = current_page.search('.rslt-brd')
      elements.each do |ele|
        name = ele.at('h2 a').inner_text if ele.at('h2 a')
        # name = "ブランドADST"
        company = ele.at('> a').inner_text if ele.at('> a')
        # company = "(ハッコー)"
        get_brand(name, company)
      end
    
      next_link = current_page.at('#gmdl-pgr .next a')
      break unless next_link
      page += 1
      sleep(1)
    end
  end

  def self.get_brand(name, company)
    agent = Mechanize.new

    name.slice!(0..3)
    brand = Brand.where(name: name).first_or_initialize
    brand.name = name
    brand.company = company.tr("()", "")

    brand.save
  end





  def self.stylingBrands
    agent = Mechanize.new
    
    page = 0

    while true
      current_page = agent.get("https://cosmeet.cosme.net/brand/search/page/#{page}/itm/923/trg/8")
      
      elements = current_page.search('.rslt-brd')
      elements.each do |ele|
        name = ele.at('h2 a').inner_text if ele.at('h2 a')
        # name = "ブランドADST"
        company = ele.at('> a').inner_text if ele.at('> a')
        # company = "(ハッコー)"
        
        get_brand(name, company)
      end
    
      next_link = current_page.at('#gmdl-pgr .next a')
      break unless next_link
      page += 1
      sleep(1)
    end
  end




  def self.waxCreamItems
    agent = Mechanize.new
    
    page = 0

    while true
      current_page = agent.get("https://cosmeet.cosme.net/product/search/page/#{page}/srt/4/itm/1092")
      
      elements = current_page.search('.mdl-pdt-idv')
      elements.each do |ele|
        name = ele.at('.info h2 a').inner_text if ele.at('.info h2 a')
        link = ele.at('.info h2 a')[:href] if ele.at('.info h2 a')
        image_url = ele.at('.pic img')[:src] if ele.at('.pic img')
        brand = ele.at('.info h2 span a').inner_text if ele.at('.info h2 span a')

        get_item(name, link, image_url, brand)
      end
    
      next_link = current_page.at('#gmdl-pgr .next a')
      break unless next_link
      page += 1
      sleep(1)
    end
  end

  def self.get_item(name, link, image_url, brand)

    item = Item.where(name: name).first_or_initialize
    item.name = name
    item.link = link
    item.image_url = image_url
    item.genre_id = 1
    item.brand_id = Brand.find_by(name: brand).id

    item.save
  end




  def self.gelItems
    agent = Mechanize.new
    
    page = 0

    while true
      current_page = agent.get("https://cosmeet.cosme.net/product/search/page/#{page}/srt/4/itm/1093")
      
      elements = current_page.search('.mdl-pdt-idv')
      elements.each do |ele|
        name = ele.at('.info h2 a').inner_text if ele.at('.info h2 a')
        link = ele.at('.info h2 a')[:href] if ele.at('.info h2 a')
        image_url = ele.at('.pic img')[:src] if ele.at('.pic img')
        brand = ele.at('.info h2 span a').inner_text if ele.at('.info h2 span a')

        get_gelitem(name, link, image_url, brand)
      end
    
      next_link = current_page.at('#gmdl-pgr .next a')
      break unless next_link
      page += 1
      sleep(1)
    end
  end

  def self.get_gelitem(name, link, image_url, brand)

    item = Item.where(name: name).first_or_initialize
    item.name = name
    item.link = link
    item.image_url = image_url
    item.genre_id = 2
    item.brand_id = Brand.find_by(name: brand).id

    item.save
  end








  def self.mooseItems
    agent = Mechanize.new
    
    page = 0

    while true
      current_page = agent.get("https://cosmeet.cosme.net/product/search/page/#{page}/srt/4/itm/1094")
      
      elements = current_page.search('.mdl-pdt-idv')
      elements.each do |ele|
        name = ele.at('.info h2 a').inner_text if ele.at('.info h2 a')
        link = ele.at('.info h2 a')[:href] if ele.at('.info h2 a')
        image_url = ele.at('.pic img')[:src] if ele.at('.pic img')
        brand = ele.at('.info h2 span a').inner_text if ele.at('.info h2 span a')

        get_mooseItem(name, link, image_url, brand)
      end
    
      next_link = current_page.at('#gmdl-pgr .next a')
      break unless next_link
      page += 1
      sleep(1)
    end
  end

  def self.get_mooseItem(name, link, image_url, brand)

    item = Item.where(name: name).first_or_initialize
    item.name = name
    item.link = link
    item.image_url = image_url
    item.genre_id = 3
    item.brand_id = Brand.find_by(name: brand).id

    item.save
  end







  def self.sprayMistItems
    agent = Mechanize.new
    
    page = 0

    while true
      current_page = agent.get("https://cosmeet.cosme.net/product/search/page/#{page}/srt/4/itm/1091")
      
      elements = current_page.search('.mdl-pdt-idv')
      elements.each do |ele|
        name = ele.at('.info h2 a').inner_text if ele.at('.info h2 a')
        link = ele.at('.info h2 a')[:href] if ele.at('.info h2 a')
        image_url = ele.at('.pic img')[:src] if ele.at('.pic img')
        brand = ele.at('.info h2 span a').inner_text if ele.at('.info h2 span a')

        get_sprayMistItem(name, link, image_url, brand)
      end
    
      next_link = current_page.at('#gmdl-pgr .next a')
      break unless next_link
      page += 1
      sleep(1)
    end
  end

  def self.get_sprayMistItem(name, link, image_url, brand)

    item = Item.where(name: name).first_or_initialize
    item.name = name
    item.link = link
    item.image_url = image_url
    item.genre_id = 4
    item.brand_id = Brand.find_by(name: brand).id

    item.save
  end





  def self.appliancesItems
    agent = Mechanize.new
    
    page = 0

    while true
      current_page = agent.get("https://cosmeet.cosme.net/product/search/page/#{page}/srt/4/itm/1065")
      
      elements = current_page.search('.mdl-pdt-idv')
      elements.each do |ele|
        name = ele.at('.info h2 a').inner_text if ele.at('.info h2 a')
        link = ele.at('.info h2 a')[:href] if ele.at('.info h2 a')
        image_url = ele.at('.pic img')[:src] if ele.at('.pic img')
        brand = ele.at('.info h2 span a').inner_text if ele.at('.info h2 span a')

        get_appliancesItem(name, link, image_url, brand)
      end
    
      next_link = current_page.at('#gmdl-pgr .next a')
      break unless next_link
      page += 1
      sleep(1)
    end
  end

  def self.get_appliancesItem(name, link, image_url, brand)

    item = Item.where(name: name).first_or_initialize
    item.name = name
    item.link = link
    item.image_url = image_url
    item.genre_id = 7
    item.brand_id = Brand.find_by(name: brand).id

    item.save
  end

end
