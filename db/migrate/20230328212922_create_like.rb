class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :posts, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
