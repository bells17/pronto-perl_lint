require 'pronto'
require 'json'
require 'shellwords'
require 'linguist'

module Pronto
  class PerlLint < Runner
    def initialize(patches, commit = nil)
      super
      @lint = "#{File.expand_path(File.dirname(__FILE__))}/../../bin/perllint"
    end

    def run
      return [] unless @patches

      @patches.select { |patch| valid_patch?(patch) }
              .map { |patch| inspect(patch) }
              .flatten.compact
    end

    def valid_patch?(patch)
      patch.additions > 0 && perl_file?(patch.new_file_full_path)
    end

    def inspect(patch)
      path = patch.new_file_full_path.to_s
      offences = run_perl_lint(path)

      offences.map do |offence|
        patch.added_lines
             .select { |line| line.new_lineno == offence['line'] }
             .map { |line| new_message(offence, line) }
      end
    end

    def new_message(offence, line)
      path = line.patch.delta.new_file[:path]
      level = :info

      Message.new(path, line, level, message(offence), nil, self.class)
    end

    def message(offence)
      "#{offence['policy']}: #{offence['description']}"
    end

    def run_perl_lint(path)
      begin
        json = `#{Shellwords.escape(@lint)} #{Shellwords.escape(path)}`
        return JSON.parse(json)
      rescue JSON::ParserError => e
        STDERR.puts e.backtrace
        return []
      end
    end

    def perl_file?(path)
      Linguist::FileBlob.new(path, Dir.pwd).language.name == 'Perl'
    end
  end
end
