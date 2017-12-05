class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when 'I 5 6'
        initialize_bitmap(5, 6)
      when 'L 1 3 A'
        color_pixel(1, 3, 'A')
      when 'V 2 3 6 W'
        draw_vertical_line(2, 3, 6, 'W')
      when 'H 3 5 2 Z'
        draw_horizontal_line(3, 5, 2, 'Z')
      when 'S'
        puts show_image
      else
        puts 'unrecognised command :('
      end
    end
  end

  private

  def initialize_bitmap(width, height, color = 'O')
    @image = Array.new(height) { Array.new(width, color)}
  end

  def show_image
    @image.map{ |row| row.join('') }.join('\n')
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

  def color_pixel(x, y, color)
    @image[y-1][x-1] = color
  end
end
