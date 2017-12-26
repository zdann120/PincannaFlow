class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_one :account, foreign_key: 'gsuite_id', primary_key: 'uid'

  def self.from_omniauth(auth)
    u = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.refresh_token = auth.credentials.refresh_token
      user.token = auth.credentials.token
      user.token_expires_at = DateTime.strptime(auth.credentials.expires_at.to_s,'%s')
      user.auth = auth
    end
    u.save
    u
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_oauth2_data"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def refresh!
    refresh_token!
  end

  private

  def refresh_token!
    response = HTTParty.post("https://accounts.google.com/o/oauth2/token",
                             body: {
                               grant_type: 'refresh_token',
                               client_id: ENV['GOOGLE_KEY'],
                               client_secret: ENV['GOOGLE_SECRET'],
                               refresh_token: refresh_token
                             }
                            )
    response = JSON.parse(response.body)
    update_attributes(
      token: response["access_token"],
      token_expires_at: Time.now + response["expires_in"].to_i.seconds
    )
  end
end
