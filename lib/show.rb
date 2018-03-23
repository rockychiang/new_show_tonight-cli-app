class Show
  attr_accessor :name, :url, :summary, :genre, :channel, :showtime, :season, :episode, :status
  @@all = []

  def initialize
    @genre = []
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end
end
