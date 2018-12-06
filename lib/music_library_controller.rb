require 'pry'

class MusicLibraryController

  attr_accessor :path

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    input = " "
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      input = gets.strip
          case input
            when "list songs"
              list_songs
            when "list artists"
              list_artists
            when "list genres"
              list_genres
            when "list artist"
                list_songs_by_artist
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song         
            end
          end
        end

 def list_songs

   idx = 1

   list_songs = Song.all.sort_by {|song| song.name}
   list_songs.each do |song|
    puts "#{idx}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    idx +=1
  end

 end
 #  Antoher way to do #list_songs using each.with_index.
 #  Song.all.sort_by{|song| song.name}.each.with_index(1) do |song, idx|
 #  puts "#{idx}. #{song.artist.name} - #{song.name} - #{song.genre.name}"

 def list_artists
   idx = 1

   list_artists = Artist.all.sort_by {|artist| artist.name}
   list_artists.each do |artist|
    puts "#{idx}. #{artist.name}"
    idx +=1
   end
 end

 def list_genres
   idx = 1

   list_genres = Genre.all.sort_by {|genre| genre.name}
   list_genres.each do |genre|
    puts "#{idx}. #{genre.name}"
    idx +=1
   end
 end

 def list_songs_by_artist
   puts "Please enter the name of an artist:"
   input = gets.strip

   if artist = Artist.find_by_name(input)
      artist.songs.sort_by {|song| song.name}.each.with_index(1) do |song, idx|
      puts "#{idx}. #{song.name} - #{song.genre.name}"
     end
   end
 end

 def list_songs_by_genre
   puts "Please enter the name of a genre:"
   input = gets.strip

   if genre = Genre.find_by_name(input)
      genre.songs.sort_by {|song| song.name}.each.with_index(1) do |song, idx|
      puts "#{idx}. #{song.artist.name} - #{song.name}"
     end
   end
 end

def play_song
   puts "Which song number would you like to play?"
   input = gets.to_i
   if input < Song.all.size && input > 0
     song = Song.all.sort{|a, b| a.name <=> b.name}[input - 1]
     puts "Playing #{song.name} by #{song.artist.name}"
   end
 end


end
