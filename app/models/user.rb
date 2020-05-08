class User < ApplicationRecord
  has_many :user_lists, dependent: :destroy
  has_many :lists, through: :user_lists
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :items, inverse_of: 'assigned_user'

  validates :username, :email, :name, :password, :password_confirmation, presence: true, on: :create
  validates :username, :email, :name, presence: true, on: :update
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :username, :email, uniqueness: true

  has_secure_password


  
  def to_param
    username
  end

  def self.search(string)
    self.where("username LIKE ?", "%#{string}%")
  end

  def sort_lists
    self.lists.sort_by { |list| list.due_date }
    incomplete_lists = self.lists.select { |list| list.items.map { |item| item.complete }.include?(false) }
    complete_lists = self.lists.select { |list| list.items.map { |item| item.complete }.all?(true) }
    incomplete_lists + complete_lists
  end
end
