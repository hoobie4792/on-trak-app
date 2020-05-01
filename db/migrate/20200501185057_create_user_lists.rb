class CreateUserLists < ActiveRecord::Migration[6.0]
  def change
    create_table :user_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
      t.boolean :is_owner, null: false, default: false

      t.timestamps
    end
  end
end
