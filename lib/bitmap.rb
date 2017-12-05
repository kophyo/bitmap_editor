class Bitmap
  DEFAULT_COLOR = 'O'.freeze

  MAX_WIDTH = MAX_HEIGHT = 250
  MIN_WIDTH = MIN_HEIGHT = 1
  attr_reader :image

  def initialize(width:, height:, color: DEFAULT_COLOR)
    @width, @height, @color = width.to_i, height.to_i, color
    validate
    initialize_pixels(@color)
  end

  def color_pixel(x:, y:, color:)
    x, y = x.to_i, y.to_i

    return unless valid_coordinates?(x, y)
    @image[y-1][x-1] = color
  end

  def draw_vertical_line(x:, from_y:, to_y:, color:)
    x, from_y, to_y = x.to_i, from_y.to_i, to_y.to_i
    return unless valid_vertical_line?(x, from_y, to_y)

    (from_y..to_y).each do |y|
      color_pixel(x: x, y: y, color: color)
    end
  end

  def draw_horizontal_line(from_x:, to_x:, y:, color:)
    from_x, to_x, y = from_x.to_i, to_x.to_i, y.to_i
    return unless valid_horizontal_line?(from_x, to_x, y)

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

  def valid_vertical_line?(x, from_y, to_y)
    valid_x?(x) && valid_y?(from_y) && valid_y?(to_y) && from_y <= to_y
  end

  def valid_horizontal_line?(from_x, to_x, y)
    valid_x?(from_x) && valid_x?(to_x) && valid_y?(y) && from_x <= to_x
  end

  def valid_coordinates?(x, y)
    valid_x?(x) && valid_y?(y)
  end
  
  def valid_x?(x)
    x.between?(MIN_WIDTH, @width)
  end

  def valid_y?(y)
    y.between?(MIN_HEIGHT, @height)
  end

  def initialize_pixels(color)
    @image = Array.new(@height) { Array.new(@width, color)}
  end

  def validate
    raise 'Invalid width & height provided. Must be between 1..250' unless valid_dimension?
  end

  def valid_dimension?
    @width.between?(MIN_WIDTH, MAX_WIDTH) &&
      @height.between?(MIN_HEIGHT, MAX_HEIGHT)
  end
end
