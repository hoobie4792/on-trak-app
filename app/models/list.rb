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

  def owner
    UserList.find_by(list: self, is_owner: true).user.username
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

  def sort_list_by(option, criteria = nil)
    items = self.items
    if option
      case option
      when "Priority"
        sorted_items = self.sort_by_priority(items, criteria)
      when "Due Date"
        sorted_items = self.sort_by_due_date(items)
      when "Category"
        sorted_items = self.sort_by_category(items, criteria)
      when "Assigned User"
        sorted_items = self.sort_by_assigned_user(items, criteria)
      else
        sorted_items = items
      end
    else
      sorted_items = items
    end

    sorted_items
  end

  def sort_by_priority(items, criteria)
    if !criteria.empty?
      criteria_items = items.select { |item| item.priority.downcase == criteria.downcase }
      non_criteria_items = items.select { |item| item.priority.downcase != criteria.downcase }
      sorted_items = criteria_items + non_criteria_items
    else
      sorted_items = items.sort_by{ |item| -Rails.application.config.item_priorities.key(item.priority.empty? ? "Very Low" : item.priority) }
    end

    sorted_items
  end

  def sort_by_due_date(items)
    items.sort_by{ |item| item.due_date.nil? ? Time.zone.local(9999999999) : item.due_date }
  end

  def sort_by_category(items, category)
    if !category.empty?
      category_items = items.select { |item| item.categories.map { |cat| cat.name.downcase }.include? category.downcase }
      non_category_items = items.select { |item| !(item.categories.map { |cat| cat.name.downcase }.include? category.downcase) }
      sorted_items = category_items + non_category_items
    else
      sorted_items = items
    end

    sorted_items
  end

  def sort_by_assigned_user(items, criteria)
    criteria_items = items.select { |item| item.assigned_user.nil? ? false : item.assigned_user.username.downcase == criteria.downcase }
    non_criteria_items = items.select { |item| item.assigned_user.nil? ? true : item.assigned_user.username.downcase != criteria.downcase }
    sorted_items = criteria_items + non_criteria_items
  end
end
