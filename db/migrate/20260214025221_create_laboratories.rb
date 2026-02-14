class CreateLaboratories < ActiveRecord::Migration[8.1]
  def change
    create_table :laboratories do |t|
      t.string :lab_code
      t.string :name
      t.integer :capacity
      t.string :location

      t.timestamps
    end
  end
end
