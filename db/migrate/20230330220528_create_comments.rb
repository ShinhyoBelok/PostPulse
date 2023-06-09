class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :posts, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
