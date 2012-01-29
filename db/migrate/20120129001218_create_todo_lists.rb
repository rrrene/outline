class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.integer :domain_id
      t.integer :user_id
      t.integer :content_id

      t.string :title
      t.integer :responsible_user_id

      t.timestamps
    end
  end
end
