class Event < ActiveRecord::Base
  has_many :swimmer_events
  has_many :swimmers, through: :swimmer_events
end
