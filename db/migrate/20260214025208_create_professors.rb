class CreateProfessors < ActiveRecord::Migration[8.1]
  def change
    create_table :professors do |t|
      t.string :professor_code
      t.string :name
      t.string :email
      t.string :program
      t.string :phone

      t.timestamps
    end
  end
end
