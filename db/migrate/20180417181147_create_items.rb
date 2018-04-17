class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.date :expiration_date
      t.integer :user_id
      t.integer :fridge_id
    end
  end
end
