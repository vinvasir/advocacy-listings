class CreateClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :claims do |t|
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true
      t.text :reason
      t.boolean :approved, default: false

      t.timestamps
    end

    add_index :claims, [:user_id, :organization_id], unique: true
  end
end
