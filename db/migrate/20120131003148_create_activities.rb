class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :domain_id
      t.integer :user_id

      t.integer :context_id
      t.integer :content_id
      
      t.string :action
      t.string :verb

      t.string :resource_type
      t.integer :resource_id

      t.timestamps
    end
  end
end
