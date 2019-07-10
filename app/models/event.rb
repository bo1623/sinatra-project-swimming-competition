class Event < ActiveRecord::Base
  has_many :swimmer_events
  has_many :swimmers, through: :swimmer_events
  has_many :timings

  def slug
    self.name.gsub(/[-']/,'').downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    #need to find a way to match slug with name or attributes of the name
    mod_slug=[slug.split("-")[0...-2].join(" "),slug.split("-")[-2..-1].join(" ")].join(" - ")
    self.find_by("LOWER(name)= ?", mod_slug)
    #find a way to remove the '-' from name and then apply LOWER?
  end

  def make_name
    "#{self.gender}s #{self.distance}m #{self.stroke} - #{self.division} Division"
  end

  def time_to_string
    self.timing.strftime("%M:%S")
  end

end
