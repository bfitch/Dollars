class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :payee
      t.integer :category_id
      t.integer :user_id

      t.timestamps
    end
  end
end
