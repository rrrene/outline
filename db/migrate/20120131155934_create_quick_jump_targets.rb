class CreateQuickJumpTargets < ActiveRecord::Migration
  def change
    create_table :quick_jump_targets do |t|
      t.integer :domain_id

      t.string :phrase

      t.string :resource_type
      t.integer :resource_id

      t.timestamps
    end
    add_index :quick_jump_targets, [:domain_id, :phrase]    
  end
end
