class XiStaticPagesCreateStaticPageVersions < ActiveRecord::Migration
  def self.up
    create_table :static_page_versions do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :static_page_versions
  end
end


# imported migration 20100823131157 create_static_page_versions from xi_static_pages
