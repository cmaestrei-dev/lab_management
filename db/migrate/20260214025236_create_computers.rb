class CreateComputers < ActiveRecord::Migration[8.1]
  def change
    create_table :computers do |t|
      t.string :serial_num
      t.string :status
      t.string :brand
      t.integer :team_num
      t.references :laboratory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
