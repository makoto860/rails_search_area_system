class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :content
      t.integer :amount
      t.text :address
      t.string :image
      t.string :user_id

      t.timestamps
    end
  end
end
