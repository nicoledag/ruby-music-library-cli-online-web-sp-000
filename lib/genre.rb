class Genre
  extend Concerns::Findable
  extend Memorable::ClassMethods

  @@all = []

  attr_accessor :name
  attr_reader :songs

  def initialize(name)
    @name = name
    @songs = [] #Has many
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def artists
    songs.collect {|song| song.artist}.uniq
  end



end
