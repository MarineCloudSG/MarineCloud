require 'rails_helper'

RSpec.describe ParameterRecommendation, type: :model do
  describe '#applies_for_value?' do
    context 'value is within range' do
      it 'returns true' do
        rec1 = create :parameter_recommendation, value_min: 10, value_max: 20
        rec2 = create :parameter_recommendation, value_min: nil, value_max: 20
        rec3 = create :parameter_recommendation, value_min: 10, value_max: nil
        rec4 = create :parameter_recommendation, value_min: nil, value_max: nil

        expect(rec1.applies_for_value?(15)).to eq true
        expect(rec2.applies_for_value?(17)).to eq true
        expect(rec3.applies_for_value?(19)).to eq true
        expect(rec4.applies_for_value?(600)).to eq true
      end
    end

    context 'value is out of range' do
      it 'returns false' do
        rec1 = create :parameter_recommendation, value_min: 10, value_max: 20
        rec2 = create :parameter_recommendation, value_min: nil, value_max: 20
        rec3 = create :parameter_recommendation, value_min: 10, value_max: nil

        expect(rec1.applies_for_value?(25)).to eq false
        expect(rec2.applies_for_value?(57)).to eq false
        expect(rec3.applies_for_value?(9)).to eq false
      end
    end
  end
end
