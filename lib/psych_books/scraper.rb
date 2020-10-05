class PsychBooks::Scraper
  @@all = []
  
  def self.all 
    @@all 
  end

  def self.scrape_books
    doc = Nokogiri::HTML(open("https://www.goodreads.com/list/show/1295.Greatest_Psychology_Books")) 
    
    books = doc.css("tr td")
    
    books.each do |book|               #make books
      title = book.css("a.bookTitle span").text
      url = book.css("a.bookTitle").attr("href")
      PsychBooks::Book.new(title, url)
    end
  end
  
  def self.scrape_book_details(book)
    basepath = "http://newenglandfallevents.com/massachusetts/pumpkin-patches/"
    doc = Nokogiri::HTML(open("#{basepath + book.url}"))
    address= doc.css("div.authorName__container a span").text
    phone = doc.css("div.readable.stacked.gcaBookDescription").text.strip
    farm.address = address
    farm.phone = phone
  end
  
end