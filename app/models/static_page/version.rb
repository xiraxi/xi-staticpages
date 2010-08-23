class StaticPage::Version < ActiveRecord::Base

  validates :name, :presence => true

  def label
    if name =~ /\Akey:(.*)\Z$/i
      I18n.t "static_pages.versions.#$1.label"
    else
      name
    end
  end

end
