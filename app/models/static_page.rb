class StaticPage < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  belongs_to :group, :class_name => "StaticPage::Group"
  belongs_to :version_of, :class_name => "StaticPage::Version"

  validates_presence_of :title, :content

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
