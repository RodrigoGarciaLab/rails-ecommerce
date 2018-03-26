class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.string :category_id
      t.boolean :featured, default: false

      t.timestamps
    end
  end
end
