require 'rails_helper'

RSpec.describe ReportGenerate, type: :job do
  describe '#perform' do
    let(:log_file_path) { Rails.public_path.join('log.txt') }
    let(:output_file_path) { '.' }

    subject { described_class.new.perform(output_file_path) }

    context 'when the log file is present and contains data' do
      it 'generates an output file with the correct data' do
        subject
        expect(File.exist?(output_file_path + '/output.json')).to be_truthy
        expected_output = [
          { "errorCount" => 248, "path" => "/path1", "successCount" => 0 },
          { "errorCount" => 250, "path" => "/api/path3", "successCount" => 2 },
          { "errorCount" => 255, "path" => "/path2", "successCount" =>1 },
          { "errorCount" => 243, "path" => "/", "successCount"=> 1 },
        ]

        output_data = JSON.parse(File.read(output_file_path + '/output.json'))

        expect(output_data).to eq(expected_output)
      end

      after do
        output_file = File.join(output_file_path, 'output.json')
        File.delete(output_file) if File.exist?(output_file)
      end
    end

    context 'when the log file is not present' do
      before do
        allow(File).to receive(:read).with(log_file_path).and_raise(Errno::ENOENT)
      end

      it 'raises an error' do
        expect { described_class.new.perform }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
