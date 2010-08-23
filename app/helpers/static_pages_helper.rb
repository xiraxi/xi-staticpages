module StaticPagesHelper

  def locales(&block)
    if @static_page and @static_page.version_of
      locales_iterator do |item|
        if alternative_page = StaticPage.find_by_version_of_id_and_locale(@static_page.version_of, item[:locale].to_s)
          item[:path_to_set] = set_locale_path(:locale => item[:locale], :return => static_page_path(alternative_page))
        end
        block.call item
      end
    else
      locales_iterator(&block)
    end
  end

end
