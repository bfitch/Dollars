class CurrentPeriod < Struct.new(:schedule)
  def as_range
    Range.new(*dates)
  end

  def dates
    [start.to_date, stop.to_date]
  end

  private

  def start
    Occurence.new schedule.previous_occurrence(today)
  end

  def stop
    Occurence.new schedule.next_occurrence(today)
  end
  
  def today
    @today ||= Time.now
  end

  class Occurence < Struct.new(:time)
    def to_date
      Date.parse(time.to_s)
    end
  end
end
