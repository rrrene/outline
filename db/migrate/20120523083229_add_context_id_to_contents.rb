class AddContextIdToContents < ActiveRecord::Migration
  def change
    add_column :contents, :context_id, :integer
    Content.reset_column_information
    Content.all.each(&:update_context)
  end
end
