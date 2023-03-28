require 'prometheus/client'
require 'file-tail'

class ReportPrometheus < ApplicationJob

  def perform()

    prometheus = Prometheus::Client.registry

    success_counter = Prometheus::Client::Counter.new(:total_sucess, docstring: "The total number of sucess HTTP requests", labels: [:path])

    error_counter = Prometheus::Client::Counter.new(:total_error, docstring: "The total number of error HTTP requests", labels: [:path])

    prometheus.register(success_counter)

    prometheus.register(error_counter)

    File.open('log_storage/log.txt') do |log|
      log.extend(File::Tail)
      log.interval # 10
      log.backward(10)
      log.tail { |line|
        object =  JSON.parse(line.gsub("'", "\""))
        if object['statusCode'].to_i >= 400
          error_counter.increment(by: 1, labels: { path: object['path'] })
        else
          success_counter.increment(by: 1, labels: { path: object['path'] })
        end
      }
    end
  end
end
