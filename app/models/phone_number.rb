class PhoneNumber < ActiveRecord::Base
  validates :number, :person_id, presence: true   #the validates must be something inherent in the object. IF you change an attribute that violates one of these
                                                  # critiria, then the object now has a non-valid state. 
end
