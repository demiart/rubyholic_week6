class Event < ActiveRecord::Base
  validates_presence_of :name, :start_time

  belongs_to :group
  belongs_to :location

  define_index do
    indexes name, description
  end

end
