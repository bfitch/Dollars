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
end
