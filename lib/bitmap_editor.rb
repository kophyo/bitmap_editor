class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when 'I 5 6'
        @bitmap = Bitmap.new(5, 6)
      when 'L 1 3 A'
        @bitmap.color_pixel(1, 3, 'A')
      when 'V 2 3 6 W'
        @bitmap.draw_vertical_line(2, 3, 6, 'W')
      when 'H 3 5 2 Z'
        @bitmap.draw_horizontal_line(3, 5, 2, 'Z')
      when 'S'
        puts @bitmap.draw_image
      else
        puts 'unrecognised command :('
      end
    end
  end

end
