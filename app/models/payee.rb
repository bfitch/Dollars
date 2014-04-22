class Payee < ActiveRecord::Base
  has_many :transactions

  def self.by_user(user)
    joins(:transactions).where("transactions.user_id = ?", user.id)
  end

  def self.search_by_name(query)
    where("name LIKE ?", "%#{query}%")
  end

  def self.distinct_by_user_and_name_search(user, query)
    by_user(user).
      search_by_name(query).
      select(:id, :name).
      distinct
  end
end
