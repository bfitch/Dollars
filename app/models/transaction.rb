class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  belongs_to :payee

  def self.total_spent_by_period(period)
    by_date_range(period).total
  end

  def self.total
    sum(:amount)
  end

  def self.by_user(user)
    where(user: user)
  end

  def self.by_category(category)
    where(category: category)
  end

  def self.by_date_range(range)
    where(date: range)
  end

  def self.ordered_by_latest_date
    order("date DESC")
  end
end
