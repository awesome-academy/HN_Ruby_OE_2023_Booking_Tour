class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def self.up
    change_table :users do |t|
      t.string :encrypted_password, null: false, default: ""
      t.datetime :remember_created_at
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
