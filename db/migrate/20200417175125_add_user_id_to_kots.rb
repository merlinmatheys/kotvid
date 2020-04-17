class AddUserIdToKots < ActiveRecord::Migration[6.0]
  def change
    add_column :kots, :user_id, :bigint
  end
end
