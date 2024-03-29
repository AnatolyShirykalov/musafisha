# == Schema Information
#
# Table name: concerts
#
#  id                 :bigint           not null, primary key
#  date               :datetime
#  row                :string
#  url                :string
#  site               :string
#  alltext            :string
#  hall_id            :bigint
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :bigint
#  image_updated_at   :datetime
#  program            :string
#  description        :string
#  tsv_body           :tsvector
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_concerts_on_hall_id   (hall_id)
#  index_concerts_on_tsv_body  (tsv_body) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (hall_id => halls.id)
#

class Concert < ApplicationRecord
  include Neighborable
  include Searcheable
  before_validation :searcheable!
  belongs_to :hall
  has_many :visits, dependent: :destroy
  has_many :audios, dependent: :destroy
  has_many :concert_tags, dependent: :destroy

  acts_as_taggable

  def searcheable!
    globalize_links!
    self.alltext =
      [program, description, hall.name, date.to_s].compact.map(&:strip).join(" ")
  end
  scope :searcheable_all, lambda { preload(:hall).find_each(&:searcheable!) }

  def globalize_links!
    begin
      u = URI.parse(url)
      doc = Nokogiri::HTML(description)
      {'img'=>'src', 'a' => 'href'}.each do |k,v|
        doc.css(k).each do |o|
          begin
            o.set_attribute(v, (u + o.attr(v)).to_s)
          rescue URI::InvalidURIError => e
            o.set_attribute(v, '')
          rescue ArgumentError => e
          end
        end
      end
      self.description = doc.to_html
    rescue => e
      puts e.backtrace
      raise e
    end
  end

  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  scope :unlooked_for, -> (user) {
    where("concerts.id IN (SELECT visits.concert_id FROM visits WHERE user_id = ? AND aasm_state = ?)" +
          " OR concerts.id NOT IN (SELECT visits.concert_id FROM visits WHERE user_id = ?)", user.id, 'unlooked', user.id)
  }

  rails_admin do
    field :hall
    field :date
    field :image
    field :url do
      pretty_value do
        %{<a href="#{value}">ссылка</a>}.html_safe
      end
    end
    field :description do
      label do
        "Desctiption"
      end
      pretty_value do
        %{<div class="concert-desc">#{value}</div>}.html_safe
      end
    end
    field :program do
      label do
        "In program"
      end
      pretty_value do
        %{<div class="concert-prog">#{value}</div>}.html_safe
      end
    end
  end
end
