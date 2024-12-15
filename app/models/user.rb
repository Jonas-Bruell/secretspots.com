class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github]


  has_one_attached :profile_picture


  has_many :secrets

  # https://dev.to/ahmadraza/google-login-in-rails-7-with-devise-2gpo#step-3-configure-controller#step-2-configure-devise-model
  def self.from_google(u)
    create_with(uid: u[:uid], provider: 'google', password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
  end

  # https://medium.com/@emdadulislam162/to-set-up-omniauth-with-github-in-a-ruby-on-rails-application-follow-these-steps-876c20c2094c#9b18
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
     # Uncomment the section below if you want users to be created if they don't exist
     unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0, 20]
        )
     end
    user
  end
end
