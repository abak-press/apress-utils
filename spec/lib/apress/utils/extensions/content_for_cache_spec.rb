require 'spec_helper'

class SomeController < ActionController::Base
  abstract!
end

RSpec.describe ActionController::Caching::Fragments do
  let(:controller) { SomeController.new }

  describe '#read_fragment' do
    context 'when string' do
      let(:string_content) { 'foo bar' }

      before { controller.write_fragment('some_key', string_content) }

      it { expect(controller.read_fragment('some_key')).to eq string_content }

      it do
        expect_any_instance_of(String).to receive(:html_safe).once

        controller.read_fragment('some_key')
      end
    end

    if Rails::VERSION::MAJOR < 4
      context 'when hash' do
        context 'when has no layout' do
          let(:hash_content) { {:foo => :bar} }

          before { controller.write_fragment('some_key', hash_content) }

          it { expect(controller.read_fragment('some_key')).to eq hash_content }
        end

        context 'when has layout key' do
          let(:hash_content) { {:layout => 'some_value', :foo => :bar} }

          before { controller.write_fragment('some_key', hash_content) }

          it { expect(controller.read_fragment('some_key')).to eq 'some_value' }

          it do
            expect_any_instance_of(String).to receive(:html_safe).once

            controller.read_fragment('some_key')

            expect(controller.cached_content_for).to eq({:foo => :bar})
          end
        end
      end
    end
  end
end
