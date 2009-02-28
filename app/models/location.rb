class Location < ActiveRecord::Base
  validates_presence_of :name, :address

  has_many :events
  has_many :groups, :through => :events

end
