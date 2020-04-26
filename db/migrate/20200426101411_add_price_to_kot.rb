class AddPriceToKot < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :price, :integer
  end
end
