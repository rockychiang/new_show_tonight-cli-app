class Scrapper
  def self.list_scrapper
    url = Nokogiri::HTML(open("https://next-episode.net/recent/"))
  end
end
