class Swimmer < ActiveRecord::Base
  belongs_to :team
  has_many :swimmer_events
  has_many :events, through: :swimmer_events
  has_many :timings

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:age].empty? &&!params[:gender].empty?
  end

  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.find_by("LOWER(name)= ?", slug.split("-").join(" "))
  end

  def division
    age=self.age
    case age
    when 12..14
      "C"
    when 15..16
      "B"
    when 17..Float::INFINITY
      "A"
    end
  end


end
