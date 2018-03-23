class Scrapper
  URL = "https://next-episode.net"

  def self.list_scrapper
    url = Nokogiri::HTML(open(URL + "/recent/"))
    url.css("#recents_wrapper td").first.css("h3").each do |episode|
      show = Show.find_or_create_by_name(episode.text)
      # show.save
      if show.url == nil
        show.url = episode.children.attribute("href").value
        self.show_scrapper(show)
      end
    end
  end

  def self.show_scrapper(show)
    url = Nokogiri::HTML(open(URL + show.url))

    show.summary = url.css("#summary").text
    url.xpath("//*[@itemprop='genre']").each{|genre| show.genre << genre.text}
    show.channel = url.css("#middle_section .sub_main")[1].text.split(" at ")[0]
    show.showtime = url.css("#middle_section .sub_main")[1].text.split(" at ")[1]
    url.xpath("//*[@class='subheadline']").remove
    show.status = url.css("#middle_section").text.gsub("\t","").split("\n").reject(&:empty?)[4]
    show.date = url.xpath("//*[@id='next_episode']").text.gsub("\t","").split("\n").reject(&:empty?)[3]
    # show.status = url.xpath("//*[@class='sub_main']", "//*[@class='subheadline']", "//*[@class='headline']").remove
    # .xpath("//*[@id='middle_section']").text.gsub("\t","").split("\n").reject(&:empty?)
    if show.status == "Running" && show.date == Time.now.strftime("%a %b %d, %Y")
      show.save
      show.episode_name = url.css("#next_episode .sub_main")[0].text
      show.episode = url.css("#next_episode .sub_main")[1].text
      show.season = url.xpath("//*[@id='next_episode']").text.gsub("\t","").split("\n").reject(&:empty?)[4]
    end
  end
end
