class CreateCategoryObjects < ActiveRecord::Migration[6.1]
  def change
    create_table :category_objects do |t|
      t.references :category, null: false, foreign_key: true
      t.references :objectable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
