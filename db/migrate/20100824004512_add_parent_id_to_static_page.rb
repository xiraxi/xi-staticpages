class AddParentIdToStaticPage < ActiveRecord::Migration
  def self.up
    add_column :static_pages, :parent_id, :integer
  end

  def self.down
    remove_column :static_pages, :parent_id
  end
end
