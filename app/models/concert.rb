class Concert < ApplicationRecord
  belongs_to :hall

  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

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
