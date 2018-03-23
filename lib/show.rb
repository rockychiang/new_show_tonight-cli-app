class Show
  attr_accessor :url, :summary, :genre, :channel, :showtime, :season, :episode, :episode_name, :status, :date
  attr_reader :name
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
    @@all.find{|show| show.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : Show.new(name)
  end
end
