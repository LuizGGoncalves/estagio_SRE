require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.in '1s' do
  ReportPrometheus.perform_now
end
