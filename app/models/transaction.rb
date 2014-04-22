class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  belongs_to :payee

  def self.by_user(user)
    where(user: user)
  end

  def self.ordered_by_latest_date
    order("date DESC")
  end
end
