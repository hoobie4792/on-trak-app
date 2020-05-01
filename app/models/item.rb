class Item < ApplicationRecord
  belongs_to :list
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  belongs_to :assigned_user, class_name: 'User', foreign_key: 'assigned_user_id'
end
