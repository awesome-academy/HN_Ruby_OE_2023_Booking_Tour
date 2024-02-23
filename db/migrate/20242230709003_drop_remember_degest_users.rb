class DropRememberDegestUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :remember_digest
  end
end
