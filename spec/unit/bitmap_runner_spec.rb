require 'bitmap_runner'

RSpec.describe BitmapRunner do

  subject { described_class.new(commands: commands) }

  let(:commands) { ['I 3 5', 'C']}
  let(:bitmap) { double(:bitmap) }

  describe '#run' do
    it 'runs commands twice' do
      expect(subject).to receive(:run_command).with('I 3 5')
      expect(subject).to receive(:run_command).with('C')
      subject.run
    end

    context 'for I command' do
      let(:commands) { ['I 3 5'] }

      it 'runs Bitmap command' do
        expect(Bitmap).to receive(:new).with(width: '3', height: '5')
        subject.run
      end
    end

    context 'for L command' do
      let(:commands) { ['L 3 5 P'] }

      before do
        subject.instance_variable_set('@bitmap', bitmap)
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:color_pixel)
          .with(x: '3', y: '5', color: 'P')
        subject.run
      end
    end

    context 'for C command' do
      let(:commands) { ['C'] }

      before do
        subject.instance_variable_set('@bitmap', bitmap)
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:clear_image)
        subject.run
      end
    end

    context 'for V command' do
      let(:commands) { ['V 3 1 5 P'] }

      before do
        subject.instance_variable_set('@bitmap', bitmap)
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:draw_vertical_line)
          .with(x: '3', from_y: '1', to_y: '5', color: 'P')
        subject.run
      end
    end

    context 'for H command' do
      let(:commands) { ['H 2 4 3 K'] }

      before do
        subject.instance_variable_set('@bitmap', bitmap)
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:draw_horizontal_line)
          .with(from_x: '2', to_x: '4', y: '3', color: 'K')
        subject.run
      end
    end

    context 'for S command' do
      let(:commands) { ['S'] }

      before do
        subject.instance_variable_set('@bitmap', bitmap)
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:draw_image)
        subject.run
      end
    end
  end
end
