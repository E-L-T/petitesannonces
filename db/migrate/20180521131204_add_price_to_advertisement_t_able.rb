class AddPriceToAdvertisementTAble < ActiveRecord::Migration[5.2]
  def change
    add_column :advertisements, :price, :integer
  end
end
