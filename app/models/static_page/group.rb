class StaticPage::Group < ActiveRecord::Base
  has_many :static_pages
end
