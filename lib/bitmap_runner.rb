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
      bitmap ? bitmap.color_pixel(x: $1, y: $2, color: $3) : no_bitmap_error(command)
    when 'C'
      bitmap ? bitmap.clear_image : no_bitmap_error(command)
    when /V (\d+) (\d+) (\d+) ([A-Z])/
      bitmap ? bitmap.draw_vertical_line(x: $1, from_y: $2, to_y: $3, color: $4) : no_bitmap_error(command)
    when /H (\d+) (\d+) (\d+) ([A-Z])/
      bitmap ? bitmap.draw_horizontal_line(from_x: $1, to_x: $2, y: $3, color: $4) : no_bitmap_error(command)
    when 'S'
      bitmap ? (puts bitmap.draw_image) : no_bitmap_error(command)
    else
      puts "Invalid Command: '#{command}'. Command discarded."
    end
  end

  def check_bitmap(cmd)
    if bitmap.nil?
      no_bitmap_error(cmd) and return false
    end
  end

  def no_bitmap_error(command)
    puts "Invalid Command: '#{command}'. Bitmap not initialized with 'I' yet!"
  end
end
