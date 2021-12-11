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
class Intoclassics::Word < ApplicationRecord
  has_many :page_words, dependent: :destroy
  has_many :words, through: :page_words
end
