class Scrapper
  def self.list_scrapper
    url = Nokogiri::HTML(open("https://next-episode.net/recent/"))
    url.css("td span div h3").each do |episode|
      show = Show.find_or_create_by_name(episode.text)
      show.url = episode.children.attribute("href").value
      show.save
    end
  end
end
