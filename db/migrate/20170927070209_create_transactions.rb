class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :received_id
      t.integer :given_id
      t.integer :number_credits
      t.timestamps
    end
  end
end
