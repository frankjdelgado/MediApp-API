class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

    	t.string :name, null: false
      t.string :email, null: false, index: true
      t.string :password_digest
      t.integer :role, default: 0
      
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
