
class XiStaticPages::LinkToVersion < XiraxiCore::Menu

  def initialize(version)
    super()
    @version = version
  end

  def visible?(controller)
    !!page
  end

  def page
    StaticPage.version_of(@version)
  end

  def path(controller)
    controller.static_page_path page
  end

  def label
    page.title
  end

end
