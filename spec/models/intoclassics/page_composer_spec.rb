# == Schema Information
#
# Table name: intoclassics_page_composers
#
#  id          :bigint           not null, primary key
#  page_id     :bigint
#  composer_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_intoclassics_page_composers_on_composer_id              (composer_id)
#  index_intoclassics_page_composers_on_composer_id_and_page_id  (composer_id,page_id) UNIQUE
#  index_intoclassics_page_composers_on_page_id                  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => intoclassics_pages.id)
#
require 'rails_helper'

RSpec.describe Intoclassics::PageComposer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
