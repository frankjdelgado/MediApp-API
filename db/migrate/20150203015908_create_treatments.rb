class CreateTreatments < ActiveRecord::Migration
  def change
    create_table :treatments do |t|
    	t.date :start
      t.date :finish
      t.string :hour
      t.integer :frequency
      t.references :user, index: true
      t.references :medication, index: true

      t.timestamps
    end
  end
end
