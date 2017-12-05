require 'bitmap'

RSpec.describe Bitmap do

  subject { described_class.new(width: width, height: height) }

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

      subject { described_class.new(width: width, height: height, color: 'A') }

      it 'sets all colors to A with override' do
        subject
        expect(subject.image).to eq(expected_image)
      end
    end

    describe 'validation' do
      context 'width' do
        context 'less than min' do
          let(:width) { -1 }

          it 'raise error' do
            expect{ subject }.to raise_error('Invalid width & height provided. Must be between 1..250')
          end
        end

        context 'more than max' do
          let(:width) { 251}

          it 'raise error' do
            expect{ subject }.to raise_error('Invalid width & height provided. Must be between 1..250')
          end
        end
      end

      context 'height' do
        context 'less than min' do
          let(:height) { -1 }

          it 'raise error' do
            expect{ subject }.to raise_error('Invalid width & height provided. Must be between 1..250')
          end
        end

        context 'more than max' do
          let(:height) { 251}

          it 'raise error' do
            expect{ subject }.to raise_error('Invalid width & height provided. Must be between 1..250')
          end
        end
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
      subject.color_pixel(x: '3', y: '4', color: 'X')
      expect(subject.image).to eq(expected_image)
    end

    context 'with out of bounds co ordinates' do
      let(:expected_image) do
        [
          %w(O O O),
          %w(O O O),
          %w(O O O),
          %w(O O O)
        ]
      end

      it 'does nothing' do
        subject.color_pixel(x: '-1', y: '8', color: 'X')
        expect(subject.image).to eq(expected_image)
      end
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
      subject.draw_vertical_line(x: '2', from_y: '1', to_y: '3', color: 'X')
      expect(subject.image).to eq(expected_image)
    end

    context 'with invalid line' do
      let(:expected_image) do
        [
          %w(O O O),
          %w(O O O),
          %w(O O O),
          %w(O O O)
        ]
      end

      it 'does nothing for out of bounds co ords' do
        subject.draw_vertical_line(x: '2', from_y: '1', to_y: '8', color: 'X')
        expect(subject.image).to eq(expected_image)
      end

      it 'does nothing for invalid range' do
        subject.draw_vertical_line(x: '2', from_y: '3', to_y: '1', color: 'X')
        expect(subject.image).to eq(expected_image)
      end
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
      subject.draw_horizontal_line(from_x: '1', to_x: '3', y: '2', color: 'X')
      expect(subject.image).to eq(expected_image)
    end

    context 'with invalid line' do
      let(:expected_image) do
        [
          %w(O O O),
          %w(O O O),
          %w(O O O),
          %w(O O O)
        ]
      end

      it 'does nothing for out of bounds co ords' do
        subject.draw_horizontal_line(from_x: '1', to_x: '8', y: '2', color: 'X')
        expect(subject.image).to eq(expected_image)
      end

      it 'does nothing for invalid range' do
        subject.draw_horizontal_line(from_x: '3', to_x: '1', y: '2', color: 'X')
        expect(subject.image).to eq(expected_image)
      end
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
      subject.draw_horizontal_line(from_x: '1', to_x: '3', y: '2', color: 'X')
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
