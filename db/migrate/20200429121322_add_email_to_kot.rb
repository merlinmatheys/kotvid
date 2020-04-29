class AddEmailToKot < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :email, :string
  end
end
