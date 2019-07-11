class Timing < ActiveRecord::Base
  belongs_to :swimmer
  belongs_to :event

  def time_to_string
    self.personal_best.strftime("%M:%S")
  end

end
