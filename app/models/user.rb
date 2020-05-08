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
    self.where("username LIKE ?", "%#{string}%").reject { |u| u.active == false }
  end

  def sort_lists
    self.lists.sort_by { |list| list.due_date }
    incomplete_lists = self.lists.select { |list| list.items.map { |item| item.complete }.include?(false) }
    complete_lists = self.lists.select { |list| list.items.map { |item| item.complete }.all?(true) }
    incomplete_lists + complete_lists
  end

  def delete_account
    self.lists.each do |list|
      ul = UserList.find_by(user: self, list: list)

      # Remove item assignments
      if ul 
        if ul.is_owner
          list.destroy
        else
          list.items.each do |item|
            if item.assigned_user == self
              item.assigned_user_id = nil
              item.save
            end
          end
        end
      end

      # Destroy UserList joiner
      ul.destroy
    end


    # Delete all group user joiners
    self.groups.each do |group|
      GroupUser.find_by(user: self, group: group).destroy
    end

    # Set inactive status
    self.active = false
    self.save
  end
end
