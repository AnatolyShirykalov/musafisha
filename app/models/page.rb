# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  enabled    :boolean          default(TRUE), not null
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  depth      :integer
#  name       :string           not null
#  content    :text
#  slug       :string           not null
#  regexp     :string
#  redirect   :string
#  fullpath   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pages_on_enabled_and_lft  (enabled,lft)
#  index_pages_on_slug             (slug) UNIQUE
#

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
