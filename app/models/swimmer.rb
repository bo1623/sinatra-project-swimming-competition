class Swimmer < ActiveRecord::Base
  belongs_to :team
  has_many :swimmer_events
  has_many :events, through: :swimmer_events

  def self.valid_params?(params)
    return !params[:name].empty? && !params[:age].empty? &&!params[:gender].empty?
  end

end
