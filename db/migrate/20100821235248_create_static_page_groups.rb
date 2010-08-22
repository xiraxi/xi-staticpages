class CreateStaticPageGroups < ActiveRecord::Migration
  def self.up
    create_table :static_page_groups do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :static_page_groups
  end
end
