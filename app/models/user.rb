class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter]

  # Logged In user information saved in db
	def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.nick_name = auth.info.name
      user.token = auth[:credentials][:token]
      user.secret = auth[:credentials][:secret]
      user.image = auth.info.image
      user.screen_name = auth.extra.raw_info.screen_name
      user.followers_count = auth.extra.raw_info.followers_count
      user.friends_count = auth.extra.raw_info.friends_count
      user.statuses_count = auth.extra.raw_info.statuses_count

      user
    end
  end
end
