class CreateOmniRegionDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :omni_region_divisions do |t|
      t.string :type
      t.references :parent, null: true, foreign_key: {to_table: :omni_region_divisions}
      t.string :code, index: {unique: true}
      t.string :name

      t.timestamps null: false
    end
  end
end
