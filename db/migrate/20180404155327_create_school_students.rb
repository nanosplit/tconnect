class CreateSchoolStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :school_students do |t|
      t.references :student, foreign_key: true
      t.references :school, foreign_key: true
      t.references :district, foreign_key: true

      t.timestamps
    end
  end
end
