class StaticPage < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true, :approximate_ascii => true

  belongs_to :version_of, :class_name => "StaticPage::Version"
  belongs_to :parent, :class_name => "StaticPage", :foreign_key => "parent_id"

  has_many :children, :class_name => "StaticPage", :foreign_key => "parent_id", :order => "position"

  validates_presence_of :title, :content
  validates :position, :numericality => { :only_integer => true }

  validate :directory_or_child
  def directory_or_child
    if work_as_directory and parent_id
      self.errors[:base] << I18n.t("activerecord.errors.static_page.directory_or_child")
    end
  end

  scope :without_parent,  where("parent_id IS NULL")
  scope :as_directory,    where(:work_as_directory => true)

  def self.version_of(version)
    if version.kind_of?(String)
      version = StaticPage::Version.find_by_name(version)
    end

    [I18n.locale.to_s, nil].each do |l|
      if p = find_by_version_of_id_and_locale(version.id, l)
        return p
      end
    end
    nil
  end
end
