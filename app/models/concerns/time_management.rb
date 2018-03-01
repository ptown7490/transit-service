# This module provides helpers to process input into Time objects
module TimeManagement
  EPOCH = Time.utc(1970)

  # extracts time literal as integer number of seconds after midnight
  def self.string_to_seconds(timeString)
    timePattern = /\A(\d{1,2}):(\d{2}):(\d{2})/
    timeString =~ timePattern
    hours = $~[1].to_i
    minutes = $~[2].to_i
    seconds = $~[3].to_i

    hours * 60 * 60 + minutes * 60 + seconds
  end

  # returns Time object, normalized for Unix epoch, Greenwich timezone
  def self.utc_time(str)
    EPOCH + self.string_to_seconds(str)
  end

end
