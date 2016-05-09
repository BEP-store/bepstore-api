require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

if Rails.env.test? || Rails.env.development?
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new do |task|
    task.requires << 'rubocop-rspec'
  end
end

if Rails.env.test? || Rails.env.development?
  RSpec::Core::RakeTask.module_eval do
    def rspec_opts
      %w(-r rspec_junit_formatter --format progress --format RspecJunitFormatter -o $CIRCLE_TEST_REPORTS/rspec/junit.xml)
    end

    def pattern
      extras = []

      BEPStore.constants.each do |engine|
        extras << File.join(BEPStore.const_get(engine)::Engine.root, 'spec', '**', '*_spec.rb').to_s unless engine == :Application
      end

      [@pattern] | extras
    end
  end
end
