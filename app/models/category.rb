class Category < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  PERIOD_OPTIONS = [
    %w{weekly weekly},
    %w{monthly monthly},
    %w{bi-monthly bi-monthly},
    %w{yearly yearly},
  ].freeze

  def self.by_user(user)
    where(user: user)
  end

  def amount_left
    allotment - spent_this_period
  end

  def spent_this_period
    transactions.total_spent_by_period(current_period)
  end

  def current_period
    CurrentPeriod.new(period).as_range
  end
end
