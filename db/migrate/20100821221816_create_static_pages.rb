class CreateStaticPages < ActiveRecord::Migration
  def self.up
    create_table :static_pages do |t|
      t.integer :position, :group_id
      t.string :name, :locale, :special_type, :description
      t.text :content, :tags
      t.boolean :draft, :front
      t.timestamps
    end
    add_index :static_pages, :group_id
  end

  def self.down
    remove_index :static_pages, :column => :group_id
    drop_table :static_pages
  end
end
