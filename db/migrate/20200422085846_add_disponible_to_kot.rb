class AddDisponibleToKot < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :disponible, :boolean
  end
end
