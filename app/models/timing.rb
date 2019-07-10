class Timing < ActiveRecord::Base
  belongs_to :swimmer
  belongs_to :event
end
