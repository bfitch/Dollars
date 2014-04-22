class Budget
  attr_accessible :user

  def initialize(user, category_class)
    @user           = user
    @category_class = category_class
  end
end
