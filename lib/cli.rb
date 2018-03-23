class CommandLineInterface
  def run
    puts "\nLoading today's new TV episodes. \n(This might take a couple of minutes)"
    Scrapper.list_scrapper
    list_show
    more_info
  end

  def list_show
    puts "\nToday's new episodes are:"
    Show.all.uniq.each_with_index do |show, index|
      puts "#{index+1}. #{show.name}"
    end
    puts ""
  end

  def more_info
    puts "If you would like get more information about a specific show enter their index number, \ntype 'list' to show the list of today's episode, or 'exit'"
    input = gets.strip
    if input.to_i.between?(0,Show.all.count)
      show_info(Show.all[input.to_i-1])
    elsif input == "list"
      list_show
      more_info
    elsif input == "exit"
    else
      invalid
      more_info
    end
  end

  def show_info(show)
    puts "\n#{show.name}"
    puts "\nSummary: #{show.summary}"
    puts "\nGenre: #{show.genre.join(", ")}"
    puts "Channel: #{show.channel}"
    puts "Showtime: #{show.showtime}"
    puts "Current Season: #{show.season}"
    puts "New Episode: #{show.episode}. #{show.episode_name}"

    puts "\nType 'list' to show the list of today's episode, or 'exit'"
    input = gets.strip
    if input == "list"
      list_show
      more_info
    elsif input == "exit"
    else
      invalid
      show_info(show)
    end
  end

  def invalid
    puts "\nInvalid command please enter a valid command."
  end

end
