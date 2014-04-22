class ChangeTransactionPayeeToPayeeId < ActiveRecord::Migration
  def change
    remove_column :transactions, :payee, :string
    add_column :transactions, :payee_id, :integer
  end
end
