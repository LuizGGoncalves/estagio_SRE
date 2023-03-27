require 'simplecov'

SimpleCov.start 'rails' do
  add_filter '/test/'
  add_filter '/config/'
  add_filter '/vendor/'
  add_filter '/channels/'
  add_filter '/mailers/'
  add_filter '/controllers'
  add_filter '/models'
  add_filter 'helpers'

  add_group 'jobs/', 'app/jobs'
  minimum_coverage 80

  add_group "Uncovered" do |file|
    if file.covered_percent < 80
      puts "#{file.filename} Nao atendeu ao limite de cobertura de teste  (cobertura:#{file.covered_percent})"
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
