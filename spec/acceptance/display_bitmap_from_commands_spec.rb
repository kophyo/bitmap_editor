require 'bitmap_editor'

RSpec.describe 'Display Bitmap pixels from commands provided' do

  subject { BitmapEditor.new }

  let(:all_valid_commands) { 'spec/fixtures/all_valid_commands.txt' }

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
    subject.run(all_valid_commands)
  end
end
