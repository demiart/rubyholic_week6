# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def get_nice_time(utctime)
    ltime = utctime #.localtime
    wday = case ltime.wday
      when 1 then "Monday"
      when 2 then "Tuesday"
      when 3 then "Wednesday"
      when 4 then "Thursday"
      when 5 then "Friday"
      when 6 then "Saturday"
      when 0 then "Sunday"
    end
    ampm = ltime.hour >= 12 ? "PM" : "AM"
    hour = ltime.hour > 12 ? ltime.hour - 12 : ltime.hour
    hour = 12 if hour == 0
    sprintf("%s, %d/%d/%d, %d:%02d:%02d %s", wday, ltime.mon + 1, ltime.day, ltime.year, hour, ltime.min, ltime.sec, ampm)
  end

end
