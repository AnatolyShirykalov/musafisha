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
FactoryGirl.define do
  factory :intoclassics_link, class: 'Intoclassics::Link' do
    url "MyString"
    page nil
  end
end
