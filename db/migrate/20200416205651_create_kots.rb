class CreateKots < ActiveRecord::Migration[6.0]
  def change
    create_table :kots do |t|
      t.string :addresse
      t.integer :prix
      t.string :quartier
      t.string :agence
      t.integer :nombre_chambres
      t.string :description

      t.timestamps
    end
  end
end
