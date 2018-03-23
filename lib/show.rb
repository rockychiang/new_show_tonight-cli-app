class Show
  attr_accessor :name, :url, :summary, :genre, :channel, :showtime, :season, :episode, :status, :date
  @@all = []

  def initialize(name)
    @name = name
    @genre = []
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    @@all.find do |show|
      show.name == name
    end
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      Show.new(name)
    end
  end
end
