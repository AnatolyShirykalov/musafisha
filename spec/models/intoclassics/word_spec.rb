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
require 'rails_helper'

RSpec.describe Intoclassics::Word, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
