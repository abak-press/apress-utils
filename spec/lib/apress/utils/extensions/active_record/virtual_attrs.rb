require 'spec_helper'

RSpec.describe Apress::Utils::Extensions::ActiveRecord::VirtualAttrs do
  describe 'virtual attributes' do
    let(:test_model) { TestModelWithVirtualAttrs.new }

    context 'when write virtual attribute' do
      it do
        expect { test_model[:test_attr] = 1 }.to_not raise_error
      end
    end

    context 'when read virtual attribute' do
      before { test_model.test_attr = 1 }

      it { expect(test_model[:test_attr]).to eq(1) }
    end
  end
end
