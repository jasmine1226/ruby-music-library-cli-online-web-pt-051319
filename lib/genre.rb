require_relative './concerns/findable.rb'

class Genre
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    Genre.all << self
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end

  def add_song(song)
    if song.genre == nil
      song.genre = self
    end
    if self.songs.include?(song) == false
      self.songs << song
    end
    if song.artist != nil && self.artists.include?(song.artist) == false
      self.artists << song.artist
    end
  end

  def artists
    artists = []
    self.songs.each do |song|
      if artists.include?(song.artist) == false
        artists << song.artist
      end
    end
    artists
  end

end
