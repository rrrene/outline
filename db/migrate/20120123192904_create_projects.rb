class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :domain_id
      t.integer :user_id

      t.string :title
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
