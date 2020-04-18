class AddTypeToKots < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :type, :string
  end
end
