require 'bitmap'

RSpec.describe Bitmap do

  subject { described_class.new(width, height) }

  let(:width) { 3 }
  let(:height) { 4 }

  describe '.initialize' do
    let(:expected_image) do
      [
        %w(O O O),
        %w(O O O),
        %w(O O O),
        %w(O O O)
      ]
    end
    it 'sets all colors to O by default' do
      expect(subject.image).to eq(expected_image)
      subject
    end

    context 'change default color' do
      let(:expected_image) do
        [
          %w(A A A),
          %w(A A A),
          %w(A A A),
          %w(A A A)
        ]
      end

      subject { described_class.new(width, height, 'A') }

      it 'sets all colors to A with override' do
        subject
        expect(subject.image).to eq(expected_image)
      end
    end
  end

  describe '#color_pixel' do
    let(:expected_image) do
      [
        %w(O O O),
        %w(O O O),
        %w(O O O),
        %w(O O X)
      ]
    end

    it 'colors pixel' do
      subject.color_pixel(3, 4, 'X')
      expect(subject.image).to eq(expected_image)
    end
  end

  describe '#draw_vertical_line' do
    let(:expected_image) do
      [
        %w(O X O),
        %w(O X O),
        %w(O X O),
        %w(O O O)
      ]
    end

    it 'draws vertical line' do
      subject.draw_vertical_line(2, 1, 3, 'X')
      expect(subject.image).to eq(expected_image)
    end
  end

  describe '#draw_horizontal_line' do
    let(:expected_image) do
      [
        %w(O O O),
        %w(X X X),
        %w(O O O),
        %w(O O O)
      ]
    end

    it 'draws horizontal line' do
      subject.draw_horizontal_line(1, 3, 2, 'X')
      expect(subject.image).to eq(expected_image)
    end
  end

  describe '#clear_image' do
    let(:expected_image) do
      [
        %w(O O O),
        %w(O O O),
        %w(O O O),
        %w(O O O)
      ]
    end

    it 'sets all colors to O' do
      subject.draw_horizontal_line(1, 3, 2, 'X')
      subject.clear_image
      expect(subject.image).to eq(expected_image)
    end
  end
  
  describe '#draw_image' do
    let(:expected_image) do
      'OOO\n'\
      'OOO\n'\
      'OOO\n'\
      'OOO'
    end

    it 'colors pixel' do
      subject
      expect(subject.draw_image).to eq(expected_image)
    end
  end
end
