class RenameCommetsToComments < ActiveRecord::Migration[7.0]
  def change
    rename_table :commets, :comments
  end
end
