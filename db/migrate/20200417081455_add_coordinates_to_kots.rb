class AddCoordinatesToKots < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :latitude, :float
    add_column :kots, :longitude, :float
  end
end
