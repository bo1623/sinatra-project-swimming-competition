class Event < ActiveRecord::Base
  has_many :swimmer_events
  has_many :swimmers, through: :swimmer_events

  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.find_by("LOWER(name)= ?", slug.split("-").join(" "))
  end

  def make_name
    "#{self.gender}'s #{self.distance}m #{self.stroke} - #{self.division} Division"
  end

end
