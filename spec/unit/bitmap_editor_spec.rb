require 'bitmap_editor'

RSpec.describe BitmapEditor do
  subject { described_class }
  let(:file) { './spec/fixtures/all_valid_commands_1.txt' }

  describe '#run' do
    let(:commands) { ['I M N X', 'S'] }
    let(:runner) { double }

    it 'runs the commands from the given file' do
      expect(File).to receive(:readlines).with(file) { commands }
      expect(BitmapRunner).to receive(:new).with(commands: commands) { runner }
      expect(runner).to receive(:run)

      subject.new.run(file)
    end

    context 'with invalid file' do
      let(:file) { './unknown.txt' }

      it 'shows an error message' do
        expect(STDOUT).to receive(:puts).with('Please provide correct file')

        subject.new.run(file)
      end
    end
  end
end
