# frozen_string_literal: true
require 'spec_helper'

describe Apress::Utils::Extensions::ActiveRecord::ValidateUniquenessInMemory do
  describe 'when no options given' do
    let(:model) { ParentErrorModel.create }

    context 'when relatives are unique' do
      let(:relative_1) { Relative.create }
      let(:relative_2) { Relative.create }

      before do
        relative_1.name = 'relative_1'
        relative_2.name = 'relative_2'

        model.relatives = [relative_1, relative_2]
        model.save
      end

      it 'is valid and has no errors' do
        expect(model).to be_valid
      end
    end

    context 'when relatives are not unique' do
      let(:relative_1) { Relative.create }
      let(:relative_2) { Relative.create }
      let(:relative_3) { Relative.create }

      before do
        relative_1.name = 'relative_1'
        relative_2.name = 'relative_1'
        relative_3.name = 'relative_3'

        model.relatives = [relative_1, relative_2, relative_3]
        model.save
      end

      it 'is not valid and has errors' do
        expect(model).to_not be_valid
      end
    end
  end

  describe 'when options given' do
    let(:model) { CollectionErrorModel.create }

    context 'when relatives are unique' do
      let(:relative_1) { Relative.create }
      let(:relative_2) { Relative.create }

      before do
        relative_1.name = 'relative_1'
        relative_2.name = 'relative_2'

        model.relatives = [relative_1, relative_2]
        model.save
      end

      it 'is valid and has no errors' do
        expect(model).to be_valid
      end
    end

    context 'when relatives are not unique' do
      let(:expected_base_error) { 'Change duplicate fields' }
      let(:expected_value_error) { 'Duplicate field' }

      let(:relative_1) { Relative.create }
      let(:relative_2) { Relative.create }
      let(:relative_3) { Relative.create }

      before do
        relative_1.name = 'relative_1'
        relative_2.name = 'relative_1'
        relative_3.name = 'relative_3'

        model.relatives = [relative_1, relative_2, relative_3]
        model.save
      end

      it 'is not valid and has errors' do
        expect(model).to_not be_valid
        expect(model.errors.messages[:base].first).to eq expected_base_error
        expect(model.errors.messages[:value].first).to eq expected_value_error
      end
    end
  end
end
