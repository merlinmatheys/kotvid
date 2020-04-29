class RemoveNombreChambresLibresFromKot < ActiveRecord::Migration[6.0]
  def change

    remove_column :kots, :nombre_chambres_libres, :integer
  end
end
