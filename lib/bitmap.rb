class Bitmap

  DEFAULT_COLOR = 'O'.freeze
  attr_reader :image
  def initialize(width, height, color = DEFAULT_COLOR)
    @width, @height, @color = width, height, color
    @image = Array.new(@height) { Array.new(@width, @color)}
  end

  def color_pixel(x, y, color)
    @image[y-1][x-1] = color
  end

  def draw_vertical_line(x, from_y, to_y, color)
    (from_y..to_y).each do |y|
      color_pixel(x, y, color)
    end
  end

  def draw_horizontal_line(from_x, to_x, y, color)
    (from_x..to_x).each do |x|
      color_pixel(x, y, color)
    end
  end

  def draw_image
    @image.map{ |row| row.join('') }.join('\n')
  end
end
