class RemoveRoleFromEmployee < ActiveRecord::Migration[6.0]
  def change
    remove_column :employees, :role
  end
end
