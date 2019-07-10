class Event < ActiveRecord::Base
  has_many :swimmer_events
  has_many :swimmers, through: :swimmer_events

  def slug
    self.name.gsub(/-/,'').downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    #need to find a way to match slug with name or attributes of the name
    self.find_by("LOWER(name)= ?", slug.split("-").join(" "))
  end

  def make_name
    "#{self.gender}s #{self.distance}m #{self.stroke} - #{self.division} Division"
  end

  def time_to_string
    self.timing.strftime("%M:%S")
  end

end
