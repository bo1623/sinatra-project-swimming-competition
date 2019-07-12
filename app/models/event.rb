class Event < ActiveRecord::Base
  has_many :swimmer_events
  has_many :swimmers, through: :swimmer_events
  has_many :timings

  def slug
    self.name.gsub(/[-']/,'').downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    mod_slug=[slug.split("-")[0...-2].join(" "),slug.split("-")[-2..-1].join(" ")].join(" - ")
    self.find_by("LOWER(name)= ?", mod_slug)
    #the challenge above was getting the slug to match the name which had a hyphen in it. Because in the slug method
    #I wanted to remove the hyphen before creating the slug and here in the find_by_slug method we're adding that hyphen back
    #so that it matches with the original name
  end

  def make_name
    "#{self.gender}s #{self.distance}m #{self.stroke} - #{self.division} Division"
  end

  def time_to_string
    self.timing.strftime("%M:%S")
  end

end
