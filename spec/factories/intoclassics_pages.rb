# == Schema Information
#
# Table name: intoclassics_pages
#
#  id         :bigint           not null, primary key
#  title      :string
#  h1         :string
#  slug       :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_intoclassics_pages_on_slug  (slug) UNIQUE
#
FactoryGirl.define do
  factory :intoclassics_page, class: 'Intoclassics::Page' do
    title "MyString"
    h1 "MyString"
    url "MyString"
  end
end
