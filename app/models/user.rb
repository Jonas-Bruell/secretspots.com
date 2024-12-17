class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :profile_picture
  has_many :secrets

  # https://youtu.be/1cuEoc59cV8?si=jGSFQwDT5Z9Z_JI9
  has_many :followed_users,
            foreign_key: :follower_id,
            class_name: 'Friend',
            dependent: :destroy
  has_many :followees,
            through: :followed_users,
            dependent: :destroy

  has_many :following_users,
            foreign_key: :followee_id,
            class_name: 'Friend',
            dependent: :destroy
  has_many :followers,
            through: :following_users,
            dependent: :destroy

  # https://youtu.be/CnZnwV38cjo?si=RIWOtrHfye9xI44s
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.full_name = auth.info.name
      # user.avatar_url = auth.info.image
    end
  end
end
