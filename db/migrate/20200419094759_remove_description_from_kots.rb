class RemoveDescriptionFromKots < ActiveRecord::Migration[6.0]
  def change

    remove_column :kots, :description, :string
  end
end
