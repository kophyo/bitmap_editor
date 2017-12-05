class Bitmap

  DEFAULT_COLOR = 'O'.freeze
  attr_reader :image
  def initialize(width:, height:, color: DEFAULT_COLOR)
    @width, @height, @color = width.to_i, height.to_i, color
    initialize_pixels(@color)
  end

  def color_pixel(x:, y:, color:)
    x, y = x.to_i, y.to_i
    
    @image[y-1][x-1] = color
  end

  def draw_vertical_line(x:, from_y:, to_y:, color:)
    x, from_y, to_y = x.to_i, from_y.to_i, to_y.to_i

    (from_y..to_y).each do |y|
      color_pixel(x: x, y: y, color: color)
    end
  end

  def draw_horizontal_line(from_x:, to_x:, y:, color:)
    from_x, to_x, y = from_x.to_i, to_x.to_i, y.to_i

    (from_x..to_x).each do |x|
      color_pixel(x: x, y: y, color: color)
    end
  end

  def draw_image
    @image.map{ |row| row.join('') }.join('\n')
  end

  def clear_image
    initialize_pixels(DEFAULT_COLOR)
  end

  private

  def initialize_pixels(color)
    @image = Array.new(@height) { Array.new(@width, color)}
  end
end
