require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject {  User.new(name: "Something") }

  it 'should require name' do 
    subject.name = nil
    expect(subject).to_not be_valid 
  end
end
