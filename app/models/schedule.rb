class Schedule < Struct.new(:category)
  def current_period
    CurrentPeriod.new(period, schedule)
  end

  def schedule
    return @schedule if @schedule
    @schedule = IceCube::Schedule.new(start_date)
    @schedule.add_recurrence_rule(rule)
    @schedule
  end

  private

  def rule
    @rule ||= RuleFactory.new(period).call
  end

  def start_date
    Time.parse(category.start_date.to_s)
  end

  def period
    category.period
  end
end
