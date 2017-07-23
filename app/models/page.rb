class Page < ApplicationRecord
  include RocketCMS::Models::Page
  RocketCMS.apply_patches self

  if respond_to?(:rails_admin)
    rails_admin &RocketCMS.page_config
  end

  def nav_options
    {html: {class: 'nav-item'}, link_html: {class: 'nav-link'}}
  end
end
