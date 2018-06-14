class AddApplicationToClaims < ActiveRecord::Migration[5.1]
  def change
    add_column :claims, :application, :text
  end
end
