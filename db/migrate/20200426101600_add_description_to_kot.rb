class AddDescriptionToKot < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :description, :string
  end
end
