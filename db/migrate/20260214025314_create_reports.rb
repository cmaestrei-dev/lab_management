class CreateReports < ActiveRecord::Migration[8.1]
  def change
    create_table :reports do |t|
      t.string :report_code
      t.text :description
      t.string :status
      t.datetime :report_date
      t.references :professor, null: false, foreign_key: true
      t.references :computer, null: false, foreign_key: true
      t.references :laboratory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
