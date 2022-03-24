# frozen_string_literal: true

require_relative "lib/archive_display/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  github = "https://github.com/mslinn/jekyll_archive_display"

  spec.authors = ["Mike Slinn"]
  spec.bindir = "exe"
  spec.description = <<~END_OF_DESC
    Jekyll tag plugin that lists the names and contents of each entry in a tar file.
  END_OF_DESC
  spec.email = ["mslinn@mslinn.com"]
  spec.files = Dir[".rubocop.yml", "LICENSE.*", "Rakefile", "{lib,spec}/**/*", "*.gemspec", "*.md"]
  spec.homepage = "https://www.mslinn.com/blog/2020/10/03/jekyll-plugins.html"
  spec.license = "MIT"
  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "bug_tracker_uri"   => "#{github}/issues",
    "changelog_uri"     => "#{github}/CHANGELOG.md",
    "homepage_uri"      => spec.homepage,
    "source_code_uri"   => github,
  }
  spec.name = "jekyll_archive_display"
  spec.post_install_message = <<~END_MESSAGE

    Thanks for installing #{spec.name}!

  END_MESSAGE
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.6.0"
  spec.summary = "Jekyll tag plugin that lists the names and contents of each entry in a tar file."
  spec.test_files = spec.files.grep(%r!^(test|spec|features)/!)
  spec.version = JekyllArchiveDisplay::VERSION

  spec.add_dependency "jekyll", ">= 3.5.0"
  spec.add_dependency "jekyll_plugin_logger"
  spec.add_dependency "ruby-filemagic", "= 0.7.3"
  spec.add_dependency "rubyzip"

  spec.add_development_dependency "debase"
  spec.add_development_dependency "rubocop-jekyll"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "ruby-debug-ide"
end
# rubocop:enable Metrics/BlockLength
