class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
    	t.string :value, null: false
      t.timestamps
    end
    add_index :units, :value, unique: true
  end
end
