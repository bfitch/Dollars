class RuleFactory < Struct.new(:period, :start_date)
  def call
    IceCube::Rule.send(*rule.recurrence).send(*rule.start_day)
  end

  def rule
    case period
    when 'weekly'
      # repeat on weekday of category.start_date
      factory [:weekly], [:day, start_date_day]
    when 'monthly'
      # repeat on first of each month
      factory [:monthly], [:day_of_month, 1]
    when 'bi-monthly'
      # repeat on first of every other month
      factory [:monthly, 2], [:day_of_month, 1]
    when 'yearly'
      # repeat on beginning of each year. category.start_date must be on or before
      # the start of Time.now's year, else will be nil.
      factory [:yearly], [:day_of_year, 1]
    end
  end

  def factory(recurrence, start_day)
    OpenStruct.new(recurrence: recurrence, start_day: start_day)
  end

  def start_date_day
    start_date.strftime("%A").downcase.to_sym
  end
end

#   start date   - date_time: 1/12/2014
#   period       - :weekly, :monthly, :yearly
#   interval     - 1: every week, 2: bi-weekly, 3: every third week
#   day_of_month - true, false
#   day_of_week  - true, false
#
# weekly
#
#   * day of the week - parse from start_date day
#
#     Rule.[period]([interval]).day([start_date.wday])
#
#     Rule.weekly(2).day(0) => "Every other Sunday"
#
# monthly
#
#   * by day of month
#
#     Rule.[period]([interval]).day_of_month([start_date.day])
#
#     Rule.monthly(1).day_of_month(10) => "The 10th of every month"
#
#
#   * by day of week
#    
#     week_of_day = if start_date.day
#       (1..7)   => 1
#       (8..14)  => 2
#       (15..21) => 3
#       (22..28) => 4
#       (29..31) => 5  => [start_date.wday, week_of_day]
#
#     Rule.[period]([interval]).day_of_week([start_date.day] => [week_of_day])
#
#     Rule.monthly(1).day_of_week(1 => [1]) => "First Monday of every month"
#
# yearly
#
#   * by day of year
#
#    Rule.[period]([interval]).day_of_year([start_date.yday])
#
#    Rule.yearly(4).day_of_year(1) => "Every fourth year on New Years Day"
#
# ----
#
#   Rule.[period]([interval]).day([start_date.wday])
#
#   Rule.[period]([interval]).day_of_month([start_date.day])
#   Rule.[period]([interval]).day_of_week([start_date.day] => [week_of_day])
#
#   Rule.[period]([interval]).day_of_year([start_date.yday])
# 
# ----
#
#   Rule.send(period, interval).send(day_method, day)
#   
