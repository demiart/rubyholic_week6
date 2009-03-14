module GroupsHelper

  def get_location_option_from_id(id)
    if id then
      begin
        loc = Location.find(id)
      rescue
        loc = Location.first
      end
    else
      loc = Location.first
    end
    [loc.name, loc.id]
  end

end
