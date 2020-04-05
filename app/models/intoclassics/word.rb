class Intoclassics::Word < ApplicationRecord
  has_many :page_words, dependent: :destroy
  has_many :words, through: :page_words
end
