
class XiStaticPages < Rails::Engine

  config.static_pages = ActiveSupport::OrderedOptions.new
  config.static_pages.attachment_size_limit = 150 * 1024 # 150 KB
  config.static_pages.attachment_path = "pagesattachments"

end
