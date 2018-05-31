class CreateAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :areas do |t|
      t.string :name
      t.string :slug
      t.string :ancestry

      t.timestamps
    end
    add_index :areas, :slug
    add_index :areas, :ancestry
  end
end
