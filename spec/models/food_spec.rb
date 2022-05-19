require 'rails_helper'

RSpec.describe Food, type: :model do
  subject { FactoryBot.create :food }

  describe 'validations' do 
    it 'should require a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should require a measurement unit' do
      subject.measurement_unit = nil
      expect(subject).to_not be_valid
    end

    it 'should require a name' do
      subject.price = nil
      expect(subject).to_not be_valid
    end
  end
end
