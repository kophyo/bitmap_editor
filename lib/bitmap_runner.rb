require_relative 'bitmap'

class BitmapRunner
  attr_reader :bitmap

  def initialize(commands:)
    @commands = commands
  end

  def run
    @commands.each { |cmd| run_command(cmd) }
  end

  private

  def run_command(command)
    case command
    when /I (\d+) (\d+)/
      @bitmap = Bitmap.new(width: $1, height: $2)
    when /L (\d+) (\d+) ([A-Z])/
      @bitmap.color_pixel(x: $1, y: $2, color: $3)
    when 'C'
      @bitmap.clear_image
    when /V (\d+) (\d+) (\d+) ([A-Z])/
      @bitmap.draw_vertical_line(x: $1, from_y: $2, to_y: $3, color: $4)
    when /H (\d+) (\d+) (\d+) ([A-Z])/
      @bitmap.draw_horizontal_line(from_x: $1, to_x: $2, y: $3, color: $4)
    when 'S'
      puts @bitmap.draw_image
    else
      puts "Invalid Command: '#{command}'. Skipping..."
    end
  end
end
