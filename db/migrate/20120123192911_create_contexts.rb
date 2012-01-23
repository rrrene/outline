class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.string :resource_type
      t.integer :resource_id
      
      t.timestamps
    end
  end
end
