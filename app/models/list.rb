class List < ApplicationRecord
  has_many :user_lists, dependent: :destroy
  has_many :users, through: :user_lists
  has_many :items, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |att| att['content'].blank? }

  def user_usernames
    self.users.map { |u| u.username }.join(", ")
  end
end
