class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string  :holder_type
      t.integer :holder_id

      t.timestamps
    end
  end
end
