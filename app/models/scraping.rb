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
      next_urlhairetsu = next_url.split("/")
      last_url = next_urlhairetsu[next_urlhairetsu.length - 1]
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
end
