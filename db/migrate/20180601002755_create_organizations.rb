class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :title
      t.text :mission
      t.references :area, foreign_key: true
      t.references :category, foreign_key: true
      t.boolean :live, default: false

      t.timestamps
    end
  end
end
