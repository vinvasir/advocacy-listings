class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug, unique: true
      t.string :ancestry

      t.timestamps
    end
    add_index :categories, :slug
    add_index :categories, :ancestry
  end
end
