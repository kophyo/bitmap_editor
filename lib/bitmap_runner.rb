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
      bitmap ? color_pixel($1, $2, $3) : no_bitmap_error(command)
    when 'C'
      bitmap ? bitmap.clear_image : no_bitmap_error(command)
    when /V (\d+) (\d+) (\d+) ([A-Z])/
      bitmap ? draw_vertical_line($1, $2, $3, $4) : no_bitmap_error(command)
    when /H (\d+) (\d+) (\d+) ([A-Z])/
      bitmap ? draw_horizontal_line($1, $2, $3, $4) : no_bitmap_error(command)
    when 'S'
      bitmap ? draw_image : no_bitmap_error(command)
    else
      puts "Invalid Command: '#{command}'. Command discarded."
    end
  end

  def color_pixel(x, y, color)
    bitmap.color_pixel(x: x, y: y, color: color)
  end

  def draw_vertical_line(x, from_y, to_y, color)
    bitmap.draw_vertical_line(x: x, from_y: from_y, to_y: to_y, color: color)
  end

  def draw_horizontal_line(from_x, to_x, y, color)
    bitmap.draw_horizontal_line(from_x: from_x, to_x: to_x, y: y, color: color)
  end

  def draw_image
    puts bitmap.draw_image
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
