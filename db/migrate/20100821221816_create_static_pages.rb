class CreateStaticPages < ActiveRecord::Migration
  def self.up
    create_table :static_pages do |t|
      t.integer :position
      t.string :name, :locale, :special_type, :description
      t.text :content
      t.references :static_page_group
      t.boolean :draft, :front
      t.timestamps
    end
    add_index :static_pages, :static_page_group_id
  end

  def self.down
    remove_index :static_pages, :column => :static_page_group_id
    drop_table :static_pages
  end
end
