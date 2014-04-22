class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.decimal :allotment
      t.string  :period
      t.integer :user_id
      t.date    :start_date

      t.timestamps
    end
  end
end
