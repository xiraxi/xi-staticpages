class AddPositionToStaticPage < ActiveRecord::Migration
  def self.up
    add_column :static_pages, :position, :integer
  end

  def self.down
    remove_column :static_pages, :position
  end
end
