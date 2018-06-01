class CreeAttributsTableComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :content, :string
    add_column :comments, :user_id, :integer
    add_column :comments, :advertisement_id, :integer
  end
end
