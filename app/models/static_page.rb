class StaticPage < ActiveRecord::Base
  belongs_to :group, :class_name => "StaticPage::Group"
end
