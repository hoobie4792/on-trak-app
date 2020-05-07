class List < ApplicationRecord
  has_many :user_lists, dependent: :destroy
  has_many :users, through: :user_lists
  has_many :items, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :items, allow_destroy: true, reject_if: proc { |att| att['content'].blank? }

  def user_usernames
    self.users.map { |u| u.username }.join(", ")
  end

  def is_owner?(user)
    UserList.find_by(list: self, user: user).is_owner
  end

  def add_group(group_id, current_user)
    group = Group.find_by(id: group_id)
    if group
      group.users.each do |user|
        if !(self.users.include? user)
          UserList.create(user: user, list: self)
        end
      end
    end
  end

  def sort_list_by(criteria, category = nil)
    items = self.items
    if criteria
      case criteria
      when "Priority"
        sorted_items = self.sort_by_priority(items)
      when "Due Date"
        sorted_items = self.sort_by_due_date(items)
      when "Category"
        sorted_items = self.sort_by_category(items, category)
      else
        sorted_items = items
      end
    else
      sorted_items = items
    end

    sorted_items
  end

  def sort_by_priority(items)
    items.sort_by{ |item| -Rails.application.config.item_priorities.key(item.priority) }
  end

  def sort_by_due_date(items)
    items.sort_by{ |item| item.due_date }
  end

  def sort_by_category(items, category)
    category_items = items.select { |item| item.categories.map { |cat| cat.name }.include? category }
    non_category_items = items.select { |item| !(item.categories.map { |cat| cat.name }.include? category) }
    category_items + non_category_items
  end
end
