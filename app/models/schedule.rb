class Schedule < Struct.new(:category)
  def current_period
    CurrentPeriod.new(schedule)
  end

  private

  def schedule
    return @schedule if @schedule
    @schedule = IceCube::Schedule.new(start_date)
    @schedule.add_recurrence_rule(rule)
    @schedule
  end

  def rule
    # pass in entire category object here
    @rule ||= RuleFactory.new(period, start_date).call
  end

  def start_date
    Time.parse(category.start_date.to_s)
  end

  def period
    category.period
  end
end
