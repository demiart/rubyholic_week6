require 'uri'

class Group < ActiveRecord::Base
  validates_presence_of :name
  validates_format_of :website_url, :with => /^((http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?)?$/ix

end