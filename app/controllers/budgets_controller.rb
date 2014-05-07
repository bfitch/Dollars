class BudgetsController < ApplicationController
  def show
    @budget = Budget.new(current_user)
  end
end
