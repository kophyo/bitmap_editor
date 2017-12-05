require 'bitmap_editor'

RSpec.describe 'Display Bitmap pixels from commands provided' do

  subject { BitmapEditor.new }

  let(:all_valid_commands_1) { 'spec/fixtures/all_valid_commands_1.txt' }
  let(:all_valid_commands_2) { 'spec/fixtures/all_valid_commands_2.txt' }
  let(:non_existent_file) { 'spec/fixtures/unknown.txt' }

  context 'shows bitmap for valid commands' do
    let(:expected_bitmap) do
      'OOOOO\n'\
      'OOZZZ\n'\
      'AWOOO\n'\
      'OWOOO\n'\
      'OWOOO\n'\
      'OWOOO'
    end

    it 'shows the bitmap' do
      expect(STDOUT).to receive(:puts).with(expected_bitmap)
      subject.run(all_valid_commands_1)
    end
  end

  context 'shows bitmap for valid commands with clear_image' do
    let(:expected_bitmap) do
      'OOOOO\n'\
      'OOOOO\n'\
      'HHHHH\n'\
      'OOOOO\n'\
      'OOOOO\n'\
      'OOOOO'
    end

    it 'shows the bitmap' do
      expect(STDOUT).to receive(:puts).with(expected_bitmap)
      subject.run(all_valid_commands_2)
    end
  end

  context 'with non-existent file' do
    it 'shows the bitmap' do
      expect(STDOUT).to receive(:puts).with('Please provide correct file')
      subject.run(non_existent_file)
    end
  end
end
