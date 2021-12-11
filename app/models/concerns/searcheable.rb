module Searcheable
  extend ActiveSupport::Concern
  included do
    include PgSearch::Model
    pg_search_scope :search, {
      against: :alltext,
      using: {
        tsearch: {
          dictionary: 'simple',
          tsvector_column: 'tsv_body',
          any_word: true
        },
      }
    }

  end
end
