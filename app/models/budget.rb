class Budget
  attr_accessor :category_class, :user

  def initialize(user, category_class = Category)
    @user           = user
    @category_class = category_class
  end

  def categories
    category_class.by_user(user)
  end
end
