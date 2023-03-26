require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.in '1s' do
  ReportGenerate.perform_later
  sleep(1)
  exit
end
