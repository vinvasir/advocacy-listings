class AddUserIdToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :user_id, :bigint
    add_index :organizations, :user_id
  end
end
