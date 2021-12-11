# == Schema Information
#
# Table name: intoclassics_links
#
#  id         :bigint           not null, primary key
#  url        :string
#  page_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :text
#
# Indexes
#
#  index_intoclassics_links_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => intoclassics_pages.id)
#
class Intoclassics::Link < ApplicationRecord
  belongs_to :page
end
