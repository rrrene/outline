class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :domain_id
      t.string :title
      t.string :style
      t.timestamps
    end
  end
end
