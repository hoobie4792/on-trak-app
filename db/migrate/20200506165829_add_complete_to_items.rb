class AddCompleteToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :complete, :boolean, default: false, null: false
  end
end
