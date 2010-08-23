class CreateStaticPageVersions < ActiveRecord::Migration
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
