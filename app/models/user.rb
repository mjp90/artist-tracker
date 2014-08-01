# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable#, :omniauth_providers => [:twitter]

  has_one :twitter_account, :as => :account_owner, :dependent => :destroy
  # has_one :facebook_account
  # has_one :soundcloud_account
  has_one :songkick_account

  has_and_belongs_to_many :artists, :join_table => :users_artists

  def create_or_update_twitter_oauth(omni_auth_request)
    account_info = {:favorites_count => omni_auth_request.extra.raw_info.favourites_count,
                    :followers_count => omni_auth_request.extra.raw_info.followers_count,
                    :friends_count   => omni_auth_request.extra.raw_info.friends_count,
                    :join_date       => omni_auth_request.extra.raw_info.created_at,
                    :language        => omni_auth_request.extra.raw_info.lang,
                    :location        => omni_auth_request.extra.raw_info.location,
                    :oauth_secret    => omni_auth_request.credentials.secret,
                    :oauth_token     => omni_auth_request.credentials.token,
                    :twitter_id      => omni_auth_request.uid,
                    :username        => omni_auth_request.extra.raw_info.screen_name
    }

    twitter_account = TwitterAccount.find_by(:twitter_id => omni_auth_request.uid)

    unless twitter_account
      twitter_account = self.build_twitter_account
    end

    twitter_account.update_attributes(account_info)
  end

  def create_or_update_facebook_oauth(omni_auth_request)
    binding.pry
    account_info = {:favorites_count => omni_auth_request.extra.raw_info.favourites_count,
                    :followers_count => omni_auth_request.extra.raw_info.followers_count,
                    :friends_count   => omni_auth_request.extra.raw_info.friends_count,
                    :join_date       => omni_auth_request.extra.raw_info.created_at,
                    :language        => omni_auth_request.extra.raw_info.lang,
                    :location        => omni_auth_request.extra.raw_info.location,
                    :oauth_secret    => omni_auth_request.credentials.secret,
                    :oauth_token     => omni_auth_request.credentials.token,
                    :twitter_id      => omni_auth_request.uid,
                    :username        => omni_auth_request.extra.raw_info.screen_name
    }

    twitter_account = TwitterAccount.find_by(:twitter_id => omni_auth_request.uid)

    unless twitter_account
      twitter_account = self.build_twitter_account
    end

    twitter_account.update_attributes(account_info)
  end
end
