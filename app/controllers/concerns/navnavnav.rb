module Navnavnav
  extend RsMenu
  def nav_extra_data_before(type, primary)
    primary.dom_class = 'nav nav-tabs justify-content-center'
  end
end
