class RuleFactory < Struct.new(:period)
  def call
    rule.send(*recurrence)
  end

  def recurrence
    case period
    when 'weekly'
      [:weekly]
    when 'monthly'
      [:monthly]
    when 'bi-monthly'
      [:monthly, 2]
    when 'yearly'
      [:yearly]
    end
  end

  def rule
    IceCube::Rule
  end
end
