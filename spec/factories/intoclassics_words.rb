# == Schema Information
#
# Table name: intoclassics_words
#
#  id      :bigint           not null, primary key
#  content :string
#
# Indexes
#
#  index_intoclassics_words_on_content  (content)
#
FactoryGirl.define do
  factory :intoclassics_word, class: 'Intoclassics::Word' do
    content "MyString"
    enabled false
  end
end
