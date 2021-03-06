class Location < ActiveRecord::Base
# for when we get geocode plugged in
  acts_as_mappable :auto_geocode => true,
                   :lat_column_name => 'latitude',
                   :lng_column_name => 'longitute'

  validates_presence_of :name, :address

  has_many :events
  has_many :groups, :through => :events

  define_index do
    indexes name, address, description
  end
end
