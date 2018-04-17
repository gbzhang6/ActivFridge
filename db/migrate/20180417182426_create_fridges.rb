class CreateFridges < ActiveRecord::Migration[5.2]
  def change
    create_table :fridges do |t|
      t.string :name
      t.string :status
  end
end
