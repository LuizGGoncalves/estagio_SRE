require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.in '2s' do
  ReportPrometheus.perform_now
end

scheduler.in '1s' do
  ReportGenerate.perform_later
end