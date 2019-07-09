class Team < ActiveRecord::Base
  has_secure_password
  has_many :swimmers
  has_many :swimmer_events
  has_many :events, through: :swimmer_events

end
