class AddRecoveryDateToKot < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :recovery_date, :string
  end
end
