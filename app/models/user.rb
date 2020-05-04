class User < ApplicationRecord
  has_many :user_lists, dependent: :destroy
  has_many :lists, through: :user_lists
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :items, inverse_of: 'assigned_user'

  validates :username, :email, :name, :password, :password_confirmation, presence: true, on: :create
  validates :username, :email, :name, presence: true, on: :update
  validates :username, :email, uniqueness: true

  has_secure_password
end
