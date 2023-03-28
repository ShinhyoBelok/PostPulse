class CreateCommet < ActiveRecord::Migration[7.0]
  def change
    create_table :commets do |t|
      t.string :text
      t.references :users, null: false, foreign_key: true
      t.references :posts, null: false, foreign_key: true

      t.timestamps
    end
  end
end
