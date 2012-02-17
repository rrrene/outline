class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :domain_id
      t.integer :user_id

      t.string :resource_type
      t.integer :resource_id

      t.timestamps
    end
  end
end
