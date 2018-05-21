class AddStateToAdvertisement < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :state, :integer, default: 0
  end
end
