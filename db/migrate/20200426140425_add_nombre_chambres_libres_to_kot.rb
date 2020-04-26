class AddNombreChambresLibresToKot < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :nombre_chambres_libres, :integer
  end
end
