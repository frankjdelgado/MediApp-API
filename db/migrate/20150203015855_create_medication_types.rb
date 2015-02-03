class CreateMedicationTypes < ActiveRecord::Migration
  def change
    create_table :medication_types do |t|
      t.string :value
      t.timestamps
    end
  end
end
