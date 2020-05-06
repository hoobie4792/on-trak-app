class Item < ApplicationRecord
  belongs_to :list, optional: true
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories
  belongs_to :assigned_user, class_name: 'User', foreign_key: 'assigned_user_id'

  validates :content, presence: true

  def set_categories(category_ids)
    # Destroy all ItemCategory rows with item == self
    item_categories = ItemCategory.select { |ic| ic.item == self }
    item_categories.each { |ic| ic.destroy }

    if !category_ids.empty?
      # Create new HeroinePower rows
      category_ids.each do |ic_id| 
        ItemCategory.create(item_id: self.id, category_id: ic_id)
      end
    end
  end 
end
