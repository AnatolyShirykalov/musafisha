class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable,  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable,  :omniauthable,
         omniauth_providers: %i[facebook vkontakte]
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.role = 'social'
      user.email = auth.info.email
      binding.pry
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar = auth.info.image
    end
  end
end
