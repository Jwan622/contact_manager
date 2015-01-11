class EmailAddress < ActiveRecord::Base
  validates :address, :person_id, presence: true
  belongs_to :person    #this is interesting. So the presence of this belongs_to :person makes rails look for columns called :person_id
end
