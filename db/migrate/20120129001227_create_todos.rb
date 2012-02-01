class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.integer :domain_id
      t.integer :user_id
      t.integer :content_id

      t.string :title
      t.boolean :active, :default => true

      t.timestamps
    end
    add_index :todos, [:content_id, :active]
  end
end
