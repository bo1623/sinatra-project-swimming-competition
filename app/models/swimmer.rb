class Swimmer < ActiveRecord::Base
  belongs_to :team
  has_many :swimmer_events
  has_many :events, through: :swimmer_events

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:age].empty? &&!params[:gender].empty?
  end

  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    self.find_by("LOWER(name)= ?", slug.split("-").join(" "))
  end


end
