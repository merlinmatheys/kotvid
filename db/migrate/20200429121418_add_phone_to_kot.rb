class AddPhoneToKot < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :phone, :string
  end
end
