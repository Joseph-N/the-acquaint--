class AddCommenteridToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commenter_id, :integer
    add_index :comments, :commenter_id
  end
end
