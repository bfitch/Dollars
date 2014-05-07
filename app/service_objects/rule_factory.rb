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
