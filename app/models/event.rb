class Event < ActiveRecord::Base
  has_many :swimmer_events
  has_many :swimmers, through: :swimmer_events

  def slug
    self.username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.find_by("LOWER(eventname)= ?", slug.split("-").join(" "))
  end

  def make_name
    name="#{self.gender}'s #{self.distance}m #{self.stroke} - #{self.division} Division"
    name
  end

end
