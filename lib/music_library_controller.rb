require 'pry'

class MusicLibraryController
  attr_accessor :path, :last_list

  def initialize(path='./db/mp3s')
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
    @last_list = []
  end

  def call
    input = ""
    until input == "exit" do
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
    end
  end

  def list_songs
    Song.all.sort_by(&:name).each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      @last_list << song
    end
  end

  def list_artists
    Artist.all.sort_by(&:name).each_with_index do |artist, i|
      puts "#{i+1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by(&:name).each_with_index do |genre, i|
      puts "#{i+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    artist = Artist.find_by_name(input)
    Song.all.select{|song| song.artist==artist}.sort_by(&:name).each_with_index do |song, i|
      puts "#{i+1}. #{song.name} - #{song.genre.name}"
      @last_list << song
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genre = Genre.find_by_name(input)
    Song.all.select{|song| song.genre==genre}.sort_by(&:name).each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name}"
      @last_list << song
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    song = Song.all.sort_by(&:name).select.with_index{|song, i| i==input-1}
      
  #  song = Song.all.sort_by(&:name)[input+1]

    puts "Playing #{song.name} by #{song.artist.name}" if input <= @last_list.length || input <= 0
  end
end
