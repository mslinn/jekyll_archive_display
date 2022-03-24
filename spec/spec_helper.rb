# frozen_string_literal: true

require "liquid"
require "jekyll_plugin_logger"

require_relative "../lib/archive_display"

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"
end
