class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # has_one :twitter_account
  # has_one :facebook_account
  # has_one :soundcloud_account
  # has_one :songkick_account

  has_and_belongs_to_many :artists, :join_table => :users_artists

end
