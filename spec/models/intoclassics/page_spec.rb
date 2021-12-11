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
require 'rails_helper'

RSpec.describe Intoclassics::Page, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
