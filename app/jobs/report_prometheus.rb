require 'prometheus/client'
require 'file-tail'

class ReportPrometheus < ApplicationJob
  def perform()
    prometheus = Prometheus::Client.registry

    logs_processed = Prometheus::Client::Counter.new(
      :logs_processed,
      docstring: 'The total number of processed logs'
    )

    logs_duration = Prometheus::Client::Summary.new(
      :logs_duration,
      docstring: 'Logs duration time',
      labels: [:env, :path, :method, :statusCode]
    )

    success_counter = Prometheus::Client::Counter.new(
      :total_sucess,
       docstring: "The total number of sucess HTTP requests",
       labels: [:path, :env]
    )

    error_counter = Prometheus::Client::Counter.new(
      :total_error,
      docstring: "The total number of error HTTP requests",
      labels: [:path, :env]
    )

    prometheus.register(success_counter)
    prometheus.register(error_counter)
    prometheus.register(logs_processed)
    prometheus.register(logs_duration)

    File.open('log_storage/log.txt') do |log|
      log.extend(File::Tail)
      log.interval
      log.backward(10)
      log.tail { |line|
        object = JSON.parse(line.gsub("'", "\""))
        logs_processed.increment
        logs_duration.observe(object['duration'].to_f, labels: {
          env: object['env'],
          path: object['path'],
          method: object['method'],
          statusCode: object['statusCode'],
        })
        if object['statusCode'].to_i >= 400
          error_counter.increment(by: 1, labels: { path: object['path'], env: object['env'] })
        else
          success_counter.increment(by: 1, labels: { path: object['path'], env: object['env'] })
        end
      }
    end
  end
end
