class Account < ActiveRecord::Base
  has_many :users

  def transactions
    Transaction.by_account(self)
  end

  def categories
    Category.by_account(self)
  end
end
