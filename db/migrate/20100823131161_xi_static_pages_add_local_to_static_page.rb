class XiStaticPagesAddLocalToStaticPage < ActiveRecord::Migration
  def self.up
    add_column :static_pages, :locale, :string
    add_column :static_pages, :version_of_id, :integer
  end

  def self.down
    remove_column :static_pages, :version_of_id
    remove_column :static_pages, :locale
  end
end


# imported migration 20100823130850 add_local_to_static_page from xi_static_pages
