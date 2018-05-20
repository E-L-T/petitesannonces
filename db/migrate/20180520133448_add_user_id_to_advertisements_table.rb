class AddUserIdToAdvertisementsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :user_id, :integer
    add_index :advertisements, :user_id
  end
end
