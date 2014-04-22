class Category < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  PERIOD_OPTIONS = %w{weekly mothly bi-weekly yearly}.freeze

  def self.by_user(user)
    where(user: user)
  end

  # allotment
  # period
  # user_id
  # start_date
end
