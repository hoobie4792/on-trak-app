# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all
List.destroy_all
User.destroy_all
Group.destroy_all


brandon = User.create(username: "brandon", name: "brandon", email: "brandon@yahoo.com", password: "brandon")
joey = User.create(username: "joey", name: "joey", email: "joey@yahoo.com", password: "joey")
robert = User.create(username: "robert", name: "robert", email: "robert@yahoo.com", password: "robert")

group1 = Group.create(name: "The Best Group Ever 1")
group2 = Group.create(name: "The Best Group Ever 2")
group3 = Group.create(name: "The Best Group Ever 3")

gu1 = GroupUser.create(user: brandon, group: group1)
gu2 = GroupUser.create(user: brandon, group: group2)
gu3 = GroupUser.create(user: brandon, group: group3)
gu4 = GroupUser.create(user: joey, group: group1)
gu5 = GroupUser.create(user: joey, group: group2)
gu6 = GroupUser.create(user: robert, group: group3)

list1 = List.create(name: "My List 1")
list2 = List.create(name: "My List 2")
list3 = List.create(name: "My List 3")

ul1 = UserList.create(user: brandon, list: list1)
ul2 = UserList.create(user: joey, list: list1)
ul3 = UserList.create(user: brandon, list: list2)
ul4 = UserList.create(user: robert, list: list2)
ul5 = UserList.create(user: brandon, list: list3)

item1 = Item.create(content: "My Item 1", priority: "Low", assigned_user: brandon, list: list1)
item2 = Item.create(content: "My Item 2", priority: "Medium", assigned_user: brandon, list: list2)
item3 = Item.create(content: "My Item 3", priority: "High", assigned_user: brandon, list: list3)
item4 = Item.create(content: "My Item 4", priority: "Medium", assigned_user: brandon, list: list1)
item5 = Item.create(content: "My Item 5", priority: "Low", assigned_user: robert, list: list2)
item6 = Item.create(content: "My Item 6", priority: "Medium", assigned_user: brandon, list: list3)
item7 = Item.create(content: "My Item 7", priority: "High", assigned_user: joey, list: list1)
item8 = Item.create(content: "My Item 8", priority: "Medium", assigned_user: brandon, list: list2)
item9 = Item.create(content: "My Item 9", priority: "Low", assigned_user: brandon, list: list3)
item10 = Item.create(content: "My Item 10", priority: "Medium", assigned_user: joey, list: list1)
item11 = Item.create(content: "My Item 11", priority: "High", assigned_user: robert, list: list2)
item12 = Item.create(content: "My Item 12", priority: "Medium", assigned_user: brandon, list: list3)

category1 = Category.create(name: "General")
category2 = Category.create(name: "Groceries")
category3 = Category.create(name: "Housework")
category4 = Category.create(name: "Chores")

ic = ItemCategory.create(item: item1, category: category1)
ic = ItemCategory.create(item: item1, category: category2)
ic = ItemCategory.create(item: item2, category: category3)
ic = ItemCategory.create(item: item2, category: category4)
ic = ItemCategory.create(item: item3, category: category1)
ic = ItemCategory.create(item: item3, category: category2)
ic = ItemCategory.create(item: item4, category: category3)
ic = ItemCategory.create(item: item4, category: category4)
ic = ItemCategory.create(item: item5, category: category1)
ic = ItemCategory.create(item: item5, category: category2)
ic = ItemCategory.create(item: item6, category: category3)
ic = ItemCategory.create(item: item6, category: category4)
ic = ItemCategory.create(item: item7, category: category1)
ic = ItemCategory.create(item: item7, category: category2)
ic = ItemCategory.create(item: item8, category: category3)
ic = ItemCategory.create(item: item8, category: category4)
ic = ItemCategory.create(item: item9, category: category1)
ic = ItemCategory.create(item: item9, category: category2)
ic = ItemCategory.create(item: item10, category: category3)
ic = ItemCategory.create(item: item10, category: category4)
ic = ItemCategory.create(item: item11, category: category1)
ic = ItemCategory.create(item: item11, category: category2)
ic = ItemCategory.create(item: item12, category: category3)
ic = ItemCategory.create(item: item12, category: category4)