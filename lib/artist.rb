require 'pry'

class Artist
  extend Concerns::Findable
  extend Memorable::ClassMethods


  @@all = []

  attr_accessor :name
  attr_reader :songs
  #returns the Artists songs.

  def initialize(name)
    @name = name
    @songs = []  #has many
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def add_song(song) #assisgns the artist to the song and then adds the song to the @songs array.
    song.artist = self unless song.artist
          #assigns the current artist to the song's 'artist' property (song belongs to artist)
          #does not assign the artist if the song already has an artist

    @songs << song unless songs.include?(song)
          #adds the song to the current artist's 'songs' collection
          #does not add the song to the current artist's collection of songs if it already exists therein
  end

  def genres
    songs.collect {|song| song.genre}.uniq
  end


end
