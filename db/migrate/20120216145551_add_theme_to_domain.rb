class AddThemeToDomain < ActiveRecord::Migration
  def change
    add_column :domains, :theme, :string
  end
end
