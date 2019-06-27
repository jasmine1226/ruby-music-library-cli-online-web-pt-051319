require_relative './concerns/findable.rb'

class Artist
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
    Artist.all << self
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    if self.songs.include?(song) == false
      self.songs << song
    end
    if song.genre != nil && self.genres.include?(song.genre) == false
      self.genres << song.genre
    end
  end

  def genres
    genres = []
    self.songs.each do |song|
      if genres.include?(song.genre) == false
        genres << song.genre
      end
    end
    genres
  end
end
