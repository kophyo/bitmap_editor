require_relative 'bitmap_runner'

class BitmapEditor
  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    commands = File.readlines(file).map(&:chomp)
    BitmapRunner.new(commands: commands).run
  end
end
