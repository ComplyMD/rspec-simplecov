module RSpec
  module SimpleCov
    class Configuration

      attr_accessor :described_thing, :context_text, :test_case_text,
                    :caller_path, :backtrace

      def describe thing
        @described_thing = thing
      end

      def context text
        @context_text = text
      end

      def it what
        @test_case_text = what
      end

      def initialize( simplecov_instance, backtrace = [],  &block )
        @described_thing = simplecov_instance
        
        @caller_path = backtrace[0].split(':').first
        @backtrace = backtrace

        minimum_line_coverage = simplecov_instance.minimum_coverage
        minimum_line_coverage = minimum_line_coverage[:line] if minimum_line_coverage.is_a?(Hash) 
        @context_text = "#minimum_coverage"
        @test_case_text = "must be at least #{minimum_line_coverage}%"

        Docile.dsl_eval( self, &block ) if block_given?
      end

    end
  end
end
