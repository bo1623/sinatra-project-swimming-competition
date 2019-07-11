class Team < ActiveRecord::Base
  has_secure_password
  has_many :swimmers
  has_many :swimmer_events
  has_many :events, through: :swimmer_events

  def slug
    self.teamname.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.find_by("LOWER(teamname)= ?", slug.split("-").join(" "))
  end

end
