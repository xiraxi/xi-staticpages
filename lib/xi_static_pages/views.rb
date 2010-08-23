
module XiStaticPagesViews
  def link_to_static_page_version(version)
    static_page = StaticPage.version_of(version)
    if static_page
      link_to static_page.title, static_page_path(static_page)
    else
      "<!-- Not found version of #{h version} -->".html_safe
    end
  end
end

class ActionView::Base
  include XiStaticPagesViews
end
