require 'rails_helper'

RSpec.describe PhoneNumber, :type => :model do
  let(:phone_number) { PhoneNumber.new(number: "2123630854", person_id: 1) }


  it 'is valid' do
    expect(phone_number).to be_valid   #phone_number is an object. It's an object that passes the validate
  end

  it 'is invalid without a number' do
    phone_number.number = nil
    expect(phone_number).to_not be_valid
  end
end
