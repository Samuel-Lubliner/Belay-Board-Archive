# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :text
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :citext
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :availabilities, dependent: :destroy

  has_many :sent_requests, class_name: 'Request', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_requests, through: :availabilities, source: :requests

  
  validates :username,
    presence: true,
    uniqueness: true,
    format: { 
      with: /\A[\w_\.]+\z/i,
      message: "can only contain letters, numbers, periods, and underscores"
    }
end
