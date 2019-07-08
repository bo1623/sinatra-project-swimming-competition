class Team < ActiveRecord::Base
  has_secure_password
  has_many :swimmers
  has_many :swimmer_events
  has_many :events, through: :swimmer_events
  #
  # def self.valid_params?(params)
  #   return !params[:name].empty? && !params[:capacity].empty?
  # end
end
