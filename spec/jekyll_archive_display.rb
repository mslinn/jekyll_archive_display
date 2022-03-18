# frozen_string_literal: true

require "jekyll"
require_relative "../lib/jekyll_archive_display"

RSpec.describe(Jekyll) do
  include Jekyll

  let(:config) { instance_double("Configuration") }
  let(:context) {
    context_ = instance_double("Liquid::Context")
    context_.config = config
    context_
  }

  it "works" do
    # expect(output).to eq("asdf")
  end
end
