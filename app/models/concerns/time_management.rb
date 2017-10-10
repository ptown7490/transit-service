module TimeManagement

  def self.convertTimeToSecondsElapsed(timeString)
    timePattern = /\A(\d{2}):(\d{2}):(\d{2})/
    timeString =~ timePattern
    hours = $~[1].to_i
    minutes = $~[2].to_i
    seconds = $~[3].to_i

    hours * 60 * 60 + minutes * 60 + seconds
  end

end
