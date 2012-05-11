class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :domain_id
      t.integer :tag_id
      t.string :resource_type
      t.integer :resource_id
      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, [:resource_id, :resource_type]
  end
end
