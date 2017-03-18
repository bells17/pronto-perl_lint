require 'spec_helper'

module Pronto
  describe PerlLint do
    let(:perl_lint) { PerlLint.new(patches) }
    let(:patches) { nil }

    describe '#run' do
      subject(:run) { perl_lint.run }

      context 'patches are nil' do
        it { should == [] }
      end

      context 'no patches' do
        let(:patches) { [] }
        it { should == [] }
      end

      context 'patches with a one error' do
        include_context 'test repo'

        let(:patches) { repo.diff('22008f3c8c8ac93dded7afbf11b449f86d6f3c4a') }

        it 'returns correct number of violations' do
          expect(run.count).to eql(1)
        end

        it 'returns expected error message' do
          expect(run.first.msg).to eql("Perl::Lint::Policy::ValuesAndExpressions::ProhibitEmptyQuotes: Quotes used with a string containing no non-whitespace characters")
        end
      end
    end
  end
end
