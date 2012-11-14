class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :store
      t.string :product
      t.string :date
      t.integer :volume

      t.timestamps
    end
    add_index :sales, :store
    add_index :sales, :product
    add_index :sales, :date
  end
end
