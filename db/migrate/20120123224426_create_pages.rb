class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :domain_id
      t.integer :user_id

      t.string :title
      t.timestamps
    end
  end
end
