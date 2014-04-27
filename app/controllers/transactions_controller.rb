require_relative '../service_objects/transaction_form'

class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new
    @categories  = categories
  end

  def create
    @transaction = TransactionForm.new(sanitized_params)
    @categories  = categories

    if @transaction.save
      redirect_to action: "index", status: 200
    else
      render "new"
    end
  end

  def index
    @transactions = Transaction.by_user(current_user).ordered_by_latest_date
  end

  private

  def categories
    @categories  ||= Category.by_user(current_user)
  end

  def sanitized_params
    params.permit(transaction: [:amount, :category_id, :date, payee: [:id, :name]])
    params[:transaction].merge(user_id: current_user.id)
  end
end
