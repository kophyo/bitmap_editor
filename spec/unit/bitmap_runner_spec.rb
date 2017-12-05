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

      context 'passing invalid commands' do
        let(:commands) { ['I A B'] }
        it 'shows a error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'I A B'. Command discarded.")
          subject.run
        end
      end
    end

    context 'for L command' do
      let(:commands) { ['I 5 5', 'L 3 5 P'] }

      before do
        allow(Bitmap).to receive(:new) { bitmap }
      end
      it 'runs Bitmap command' do
        expect(bitmap).to receive(:color_pixel)
          .with(x: '3', y: '5', color: 'P')
        subject.run
      end

      context 'passing invalid commands' do
        let(:commands) { ['L A B C'] }
        it 'shows a error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'L A B C'. Command discarded.")
          subject.run
        end
      end
    end

    context 'for C command' do
      let(:commands) { ['I 5 5', 'C'] }

      before do
        allow(Bitmap).to receive(:new) { bitmap }
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:clear_image)
        subject.run
      end
    end

    context 'for V command' do
      let(:commands) { ['I 5 5', 'V 3 1 5 P'] }

      before do
        allow(Bitmap).to receive(:new) { bitmap }
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:draw_vertical_line)
          .with(x: '3', from_y: '1', to_y: '5', color: 'P')
        subject.run
      end

      context 'passing invalid commands' do
        let(:commands) { ['V A B C D'] }
        it 'shows a error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'V A B C D'. Command discarded.")
          subject.run
        end
      end
    end

    context 'for H command' do
      let(:commands) { ['I 5 5', 'H 2 4 3 K'] }

      before do
        allow(Bitmap).to receive(:new) { bitmap }
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:draw_horizontal_line)
          .with(from_x: '2', to_x: '4', y: '3', color: 'K')
        subject.run
      end

      context 'passing invalid commands' do
        let(:commands) { ['H A B C D'] }
        it 'shows a error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'H A B C D'. Command discarded.")
          subject.run
        end
      end
    end

    context 'for S command' do
      let(:commands) { ['I 5 5', 'S'] }

      before do
        allow(Bitmap).to receive(:new) { bitmap }
      end

      it 'runs Bitmap command' do
        expect(bitmap).to receive(:draw_image)
        subject.run
      end
    end

    context 'passing invalid commands' do
      let(:commands) { ['X'] }
      it 'shows a error message' do
        expect(STDOUT).to receive(:puts)
          .with("Invalid Command: 'X'. Command discarded.")
        subject.run
      end
    end

    context 'running any command without initializing bitmap' do

      context 'for L command' do
        let(:commands) { ['L 3 5 A'] }
        it 'shows no bitmap error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'L 3 5 A'. Bitmap not initialized with 'I' yet!")
          subject.run
        end
      end

      context 'for C command' do
        let(:commands) { ['C'] }
        it 'shows no bitmap error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'C'. Bitmap not initialized with 'I' yet!")
          subject.run
        end
      end

      context 'for V command' do
        let(:commands) { ['V 3 3 5 K'] }
        it 'shows no bitmap error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'V 3 3 5 K'. Bitmap not initialized with 'I' yet!")
          subject.run
        end
      end

      context 'for H command' do
        let(:commands) { ['H 3 3 5 K'] }
        it 'shows no bitmap error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'H 3 3 5 K'. Bitmap not initialized with 'I' yet!")
          subject.run
        end
      end

      context 'for S command' do
        let(:commands) { ['S'] }
        it 'shows no bitmap error message' do
          expect(STDOUT).to receive(:puts)
            .with("Invalid Command: 'S'. Bitmap not initialized with 'I' yet!")
          subject.run
        end
      end
    end
  end
end
