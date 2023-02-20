require 'jekyll_plugin_logger'
require 'rubygems/package'
require 'ruby-filemagic'
require_relative 'archive_display/version'

module JekyllPluginArchiveDisplayName
  PLUGIN_NAME = 'archive_display'.freeze
end

# Jekyll tag plugin that displays information about the contents of tar files
module Jekyll
  # Executes a program and returns the output from STDOUT.
  class ArchiveDisplayTag < Liquid::Tag
    # @param tag_name [String] is the name of the tag, which we already know.
    # @param command_line [Hash, String, Liquid::Tag::Parser] the arguments from the web page.
    # @param tokens [Liquid::ParseContext] tokenized command line
    # @return [void]
    def initialize(tag_name, archive_name, tokens)
      super(tag_name, archive_name, tokens)
      @logger = PluginMetaLogger.instance.new_logger(self, PluginMetaLogger.instance.config)
      @archive_name = archive_name.strip
    end

    # Method prescribed by the Jekyll plugin lifecycle.
    # @return [String]
    def render(context)
      source = context.registers[:site].config['source']
      tar_name = "#{source}/#{@archive_name}"
      @logger.debug "tar_name=#{tar_name}"
      traverse_tar(tar_name)
    end

    private

    def display_entry(entry)
      heading = "<div class='codeLabel'>#{entry[:name]} <span style='font-size: smaller'>(#{entry[:fm_type]})</span></div>"
      if entry[:is_text]
        "#{heading}\n<pre data-lt-active='false'>#{entry[:content]}</pre>"
      else
        "#{heading}\n<p><i>Binary file</i></pre>"
      end
    end

    # Process one tar entry
    def tar_entry(entry, file_magic)
      content = entry.read
      fm_type = file_magic.buffer(content)

      {
        name:    entry.full_name,
        content: content.strip,
        is_text: (fm_type.start_with? 'text'),
        fm_type: fm_type,
      }
    end

    # Walk through a `tar` file.
    #
    # Modified from this {https://gist.github.com/sinisterchipmunk/1335041/5be4e6039d899c9b8cca41869dc6861c8eb71f13 gist by sinisterchipmunk }.
    # See https://docs.ruby-lang.org/en/2.6.0/Gem/Package/TarReader.html
    #
    # @param tar_name [String] Name of tar file to examine.
    # @return [String] containing HTML describing the contents of the `tar`.
    def traverse_tar(tar_name)
      file_magic = FileMagic.new(FileMagic::MAGIC_MIME)
      result = ''
      File.open(tar_name, 'rb') do |file|
        Gem::Package::TarReader.new(file) do |tar|
          contents = tar.each.map do |entry|
            next unless entry.file?

            tar_entry(entry, file_magic)
          end
          result = contents
                   .compact
                   .sort_by { |entry| entry[:name] }
                   .map { |entry| display_entry entry }
                   .join("\n")
        end
      end
      @logger.debug { "traverse_tar: result = #{result}" }
      result
    end
  end
end

PluginMetaLogger.instance.info { "Loaded #{JekyllPluginArchiveDisplayName::PLUGIN_NAME} v#{JekyllArchiveDisplayVersion::VERSION} plugin." }
Liquid::Template.register_tag(JekyllPluginArchiveDisplayName::PLUGIN_NAME, Jekyll::ArchiveDisplayTag)
