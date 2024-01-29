class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :image
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
