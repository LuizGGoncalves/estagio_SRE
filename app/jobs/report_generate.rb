class ReportGenerate < ApplicationJob
  def perform(path= 'output_data/sre-intern-test')
    results = generate_json_repot(logs_data)
    save_repot_json_local(results, path)
  end

  private

  def generate_json_repot(logs_array)
    logs_array.each_with_object([]) do |log, results|
      result = results.find { |r| r[:path] == log['path'] }
      unless result
        result = { path: log['path'], errorCount: 0, successCount: 0 }
        results << result
      end
      log['statusCode'].to_i >= 400 ? result[:errorCount] += 1 : result[:successCount] += 1
    end
  end

  def logs_data
    logs_string = File.read(Rails.public_path.join('log.txt'))
    JSON.parse("[#{logs_string.gsub("'", "\"").gsub!(/\n/, ',')}]")
  end

  def save_repot_json_local(results, path)
    unless Dir.exist?(path)
      Dir.mkdir(path)
    end

    File.open(path + '/output.json', 'w') do |file|
      file.write(JSON.generate(results))
    end
  end
end
