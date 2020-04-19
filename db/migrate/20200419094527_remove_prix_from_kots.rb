class RemovePrixFromKots < ActiveRecord::Migration[6.0]
  def change

    remove_column :kots, :prix, :integer
  end
end
