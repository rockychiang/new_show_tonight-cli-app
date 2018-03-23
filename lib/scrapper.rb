class Scrapper
  URL = "https://next-episode.net"

  def self.list_scrapper
    url = Nokogiri::HTML(open(URL + "/recent/"))
    url.css("td span div h3").each do |episode|
      if Show.find_by_name(episode.text) == nil
        show = Show.find_or_create_by_name(episode.text)
        show.url = episode.children.attribute("href").value
        self.show_scrapper(show)
      end
    end
  end

  def self.show_scrapper(show)
    url = Nokogiri::HTML(open(URL + show.url))
    show.status = url.xpath("//*[@class='sub_main']", "//*[@class='subheadline']", "//*[@class='headline']")
    .remove.xpath("//*[@id='middle_section']").text.gsub("\t","").split("\n").reject(&:empty?)[1]
    if show.status == "Running"
      show.save
    end
  end
end
