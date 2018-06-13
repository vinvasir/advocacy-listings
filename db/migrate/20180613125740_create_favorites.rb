class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.bigint :favoritable_id
      t.string :favoritable_type
    end
    
    add_index :favorites, [:favoritable_id, :favoritable_type]
  end
end
