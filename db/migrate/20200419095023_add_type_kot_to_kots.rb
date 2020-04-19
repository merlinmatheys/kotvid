class AddTypeKotToKots < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :type_kot, :string
  end
end
