class RemoveTypeFromKots < ActiveRecord::Migration[6.0]
  def change

    remove_column :kots, :type, :string
  end
end
