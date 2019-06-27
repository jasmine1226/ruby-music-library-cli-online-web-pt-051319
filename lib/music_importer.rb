require_relative './artist.rb'
require_relative './song.rb'
require_relative './genre.rb'
require_relative './music_library_controller.rb'

class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
    @files = []
  end

  def files
    current_dir = Dir.getwd
    Dir.chdir(@path)
    @files = Dir.glob("*.mp3")
    Dir.chdir(current_dir)
    @files
  end

  def import
    self.files
    songs = []
    @files.each do |file|
      songs = Song.create_from_filename(file)
    end
    songs
  end
end
