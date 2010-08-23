class XiStaticPagesCreateStaticPageGroups < ActiveRecord::Migration
  def self.up
    create_table :static_page_groups do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :static_page_groups
  end
end


# imported migration 20100821235248 create_static_page_groups from xi_static_pages
