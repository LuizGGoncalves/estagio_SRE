class ReportGenerate < ApplicationJob
  def perform
    logs_string = File.read(Rails.public_path.join('log.txt'))
    logs_array = JSON.parse("[#{logs_string.gsub("'", "\"").gsub!(/\n/, ',')}]")
    paths = logs_array.map { |log| log['path'] }
    unique_paths = paths.uniq

    results = []
    unique_paths.each do |path|
      results.push({ path: path, errorCount: 0, successCount: 0 })
    end

    logs_array.each do |log|
      results.each do |result|
        if log['path'] == result[:path]
          log['statusCode'].to_i >= 400 ? result[:errorCount] += 1 : result[:successCount] += 1
        end
      end
    end

    unless Dir.exist?('output_data/sre-intern-test')
      Dir.mkdir('output_data/sre-intern-test')
    end

    File.open('output_data/sre-intern-test/output.json', 'w') do |file|
      file.write(JSON.generate(results))
    end
  end
end