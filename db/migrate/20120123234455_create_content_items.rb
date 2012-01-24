class CreateContentItems < ActiveRecord::Migration
  def change
    create_table :content_items do |t|
      t.integer :content_id
      t.integer :position

      t.string  :item_type
      t.integer :item_id

      t.timestamps
    end
  end
end
