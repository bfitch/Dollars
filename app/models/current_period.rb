class CurrentPeriod < Struct.new(:period)
  def dates
    [start, stop]
  end

  def as_range
    Range.new(*dates)
  end

  private

  def stop
    @stop ||= Date.current
  end
  
  def start
    case period
    when 'weekly'
      stop.beginning_of_week
    when 'monthly'
      stop.beginning_of_month
    # when 'bi-monthly'
    #   [:monthly, 2]
    when 'yearly'
      stop.beginning_of_year
    end
  end
end
