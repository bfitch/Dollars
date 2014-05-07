class TransactionForm
  include Virtus.model

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :amount, Float
  attribute :category_id, Integer
  attribute :user_id, Integer
  attribute :date, Date
  attribute :payee, Hash[Symbol => String]

  # validates :amount, format: { with: /\d+\.\d{2}/,
  #   message: "must be integers in currency format" }
  validates :category_id, :user_id, :date, :payee, presence: true

  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    @payee       = Payee.where(name: payee[:name]).first_or_create
    @transaction = Transaction.create(transaction_attrs)
  end

  def transaction_attrs
    { amount:      amount,
      category_id: category_id,
      user_id:     user_id,
      date:        date,
      payee_id:    @payee.id }
  end
end
