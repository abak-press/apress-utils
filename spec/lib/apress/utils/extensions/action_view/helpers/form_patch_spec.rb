# frozen_string_literal: true
require 'spec_helper'

RSpec.describe ActionView::Helpers::FormHelper, type: :helper do
  describe '#html_options_for_form' do
    let(:expected_html) do
      {
        'accept-charset' => 'UTF-8',
        'action' => '/spec',
        'onsubmit' => 'formSubmitter.disableButtons(this, null, null);'
      }
    end
    let(:result) { helper.html_options_for_form({controller: :application, action: :show}, {}) }

    it do
      expect(result).to eq(expected_html)
    end
  end
end
