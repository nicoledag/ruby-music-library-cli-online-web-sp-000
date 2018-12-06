require 'pry'

class Song
  extend Concerns::Findable
  extend Memorable::ClassMethods

  @@all = []

  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist = nil, genre = nil) #defaults artist
    @name = name
    self.artist = artist
    self.genre = genre
     #invokes #artist= instead of simply assigning to an @artist instance variable to ensure that associations
     #are created upon initialization.  It evokes artist= method below if their is an artist.
  end

  def artist=(artist)
    if artist != nil
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if genre != nil
      @genre = genre
      genre.songs << self unless genre.songs.include? self
    end
  end

  def self.all
    @@all
  end

  def save
    @@all << self #self.class.all
  end

  def self.create(name)
    song = Song.new(name) #maybe just need new(name)
    song.save
    song
  end

  def self.new_from_filename(filename)
    split_name = filename.split(" - ")
    artist = split_name[0]
    song = split_name[1]
    genre = split_name[2].chomp(".mp3")
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    new(song, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end


end
