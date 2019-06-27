require_relative './concerns/findable.rb'

class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    Song.all << self
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.create(name, artist = nil, genre = nil)
    song = self.new(name, artist, genre)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.find_by_name(name)
    output = nil
    self.all.each do |song|
      if song.name == name
        output = song
      end
    end
    output
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ? self.find_by_name(name) : self.create(name)
  end

  def self.new_from_filename(file)
    file = File.basename(file,".mp3").split(" - ")
    artist = Artist.find_or_create_by_name(file[0])
    genre = Genre.find_or_create_by_name(file[2])
    Song.Genre.find_or_create_by_name(create(file[1], artist, genre)
  end

  def self.create_from_filename(file)
    song = Song.new_from_filename(file)
    self.all << song
  end
end
