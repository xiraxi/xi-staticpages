
XiSearch.use_model proc { StaticPage.where("locale = ? or locale is null", I18n.locale.to_s) }, :show_more => false
