class XiStaticPagesCreateStaticPages < ActiveRecord::Migration
  def self.up
    create_table :static_pages do |t|
      t.string :title
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :static_pages
  end
end


# imported migration 20100821221816 create_static_pages from xi_static_pages
