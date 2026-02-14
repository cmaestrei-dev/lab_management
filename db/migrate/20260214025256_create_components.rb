class CreateComponents < ActiveRecord::Migration[8.1]
  def change
    create_table :components do |t|
      t.string :serial_num
      t.string :name
      t.string :brand
      t.string :status
      t.references :computer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
