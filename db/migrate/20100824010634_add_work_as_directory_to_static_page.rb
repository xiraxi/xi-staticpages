class AddWorkAsDirectoryToStaticPage < ActiveRecord::Migration
  def self.up
    add_column :static_pages, :work_as_directory, :boolean
  end

  def self.down
    remove_column :static_pages, :work_as_directory
  end
end
