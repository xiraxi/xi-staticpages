class StaticPage < ActiveRecord::Base

  belongs_to :group, :class_name => "StaticPage::Group", :foreign_key => "group_id"

  validates_presence_of :title, :content
end
