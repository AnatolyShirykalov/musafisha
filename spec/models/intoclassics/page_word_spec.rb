# == Schema Information
#
# Table name: intoclassics_page_words
#
#  id      :bigint           not null, primary key
#  page_id :bigint
#  word_id :bigint
#
# Indexes
#
#  index_intoclassics_page_words_on_page_id              (page_id)
#  index_intoclassics_page_words_on_word_id              (word_id)
#  index_intoclassics_page_words_on_word_id_and_page_id  (word_id,page_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (page_id => intoclassics_pages.id)
#  fk_rails_...  (word_id => intoclassics_words.id)
#
require 'rails_helper'

RSpec.describe Intoclassics::PageWord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
